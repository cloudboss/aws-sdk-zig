const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const SendBonusInput = struct {
    /// The ID of the assignment for which this bonus is paid.
    assignment_id: []const u8,

    /// The Bonus amount is a US Dollar amount specified using a string (for
    /// example, "5" represents $5.00 USD and
    /// "101.42" represents $101.42 USD). Do not include currency symbols or
    /// currency codes.
    bonus_amount: []const u8,

    /// A message that explains the reason for the bonus payment. The
    /// Worker receiving the bonus can see this message.
    reason: []const u8,

    /// A unique identifier for this request, which allows you to
    /// retry the call on error without granting multiple bonuses. This is
    /// useful in cases such as network timeouts where it is unclear whether
    /// or not the call succeeded on the server. If the bonus already exists
    /// in the system from a previous call using the same UniqueRequestToken,
    /// subsequent calls will return an error with a message containing the
    /// request ID.
    unique_request_token: ?[]const u8 = null,

    /// The ID of the Worker being paid the bonus.
    worker_id: []const u8,

    pub const json_field_names = .{
        .assignment_id = "AssignmentId",
        .bonus_amount = "BonusAmount",
        .reason = "Reason",
        .unique_request_token = "UniqueRequestToken",
        .worker_id = "WorkerId",
    };
};

pub const SendBonusOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SendBonusInput, options: CallOptions) !SendBonusOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "mturk-requester", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: SendBonusInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mturk-requester", "MTurk", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "MTurkRequesterServiceV20170117.SendBonus");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SendBonusOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
