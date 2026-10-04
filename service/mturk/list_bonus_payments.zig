const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BonusPayment = @import("bonus_payment.zig").BonusPayment;

pub const ListBonusPaymentsInput = struct {
    /// The ID of the assignment associated with the bonus payments
    /// to retrieve. If specified, only bonus payments for the given
    /// assignment are returned. Either the HITId parameter or the
    /// AssignmentId parameter must be specified
    assignment_id: ?[]const u8 = null,

    /// The ID of the HIT associated with the bonus payments to
    /// retrieve. If not specified, all bonus payments for all assignments
    /// for the given HIT are returned. Either the HITId parameter or the
    /// AssignmentId parameter must be specified
    hit_id: ?[]const u8 = null,

    max_results: ?i32 = null,

    /// Pagination token
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .assignment_id = "AssignmentId",
        .hit_id = "HITId",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListBonusPaymentsOutput = struct {
    /// A successful request to the ListBonusPayments operation
    /// returns a list of BonusPayment objects.
    bonus_payments: ?[]const BonusPayment = null,

    next_token: ?[]const u8 = null,

    /// The number of bonus payments on this page in the filtered
    /// results list, equivalent to the number of bonus payments being
    /// returned by this call.
    num_results: ?i32 = null,

    pub const json_field_names = .{
        .bonus_payments = "BonusPayments",
        .next_token = "NextToken",
        .num_results = "NumResults",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListBonusPaymentsInput, options: CallOptions) !ListBonusPaymentsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListBonusPaymentsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "MTurkRequesterServiceV20170117.ListBonusPayments");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListBonusPaymentsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListBonusPaymentsOutput, body, allocator);
}
