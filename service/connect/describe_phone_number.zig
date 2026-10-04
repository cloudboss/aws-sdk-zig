const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ClaimedPhoneNumberSummary = @import("claimed_phone_number_summary.zig").ClaimedPhoneNumberSummary;

pub const DescribePhoneNumberInput = struct {
    /// A unique identifier for the phone number.
    phone_number_id: []const u8,

    pub const json_field_names = .{
        .phone_number_id = "PhoneNumberId",
    };
};

pub const DescribePhoneNumberOutput = struct {
    /// Information about a phone number that's been claimed to your Connect
    /// Customer instance or traffic distribution group.
    claimed_phone_number_summary: ?ClaimedPhoneNumberSummary = null,

    pub const json_field_names = .{
        .claimed_phone_number_summary = "ClaimedPhoneNumberSummary",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribePhoneNumberInput, options: CallOptions) !DescribePhoneNumberOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "connect", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribePhoneNumberInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/phone-number/");
    try path_buf.appendSlice(allocator, input.phone_number_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribePhoneNumberOutput {
    const result: DescribePhoneNumberOutput = try aws.json.parseJsonObject(
        DescribePhoneNumberOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
