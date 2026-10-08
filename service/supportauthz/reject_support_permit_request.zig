const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const RejectSupportPermitRequestInput = struct {
    /// The ARN of the permit request to reject.
    request_arn: []const u8,

    pub const json_field_names = .{
        .request_arn = "requestArn",
    };
};

pub const RejectSupportPermitRequestOutput = struct {
    /// The ARN of the rejected permit request.
    request_arn: []const u8,

    pub const json_field_names = .{
        .request_arn = "requestArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RejectSupportPermitRequestInput, options: CallOptions) !RejectSupportPermitRequestOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "supportauthz", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: RejectSupportPermitRequestInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("supportauthz", "SupportAuthZ", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/support-permit-requests/");
    try path_buf.appendSlice(allocator, input.request_arn);
    try path_buf.appendSlice(allocator, "/reject");
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RejectSupportPermitRequestOutput {
    const result: RejectSupportPermitRequestOutput = try aws.json.parseJsonObject(
        RejectSupportPermitRequestOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
