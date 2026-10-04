const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BatchUnameErrorResponseItem = @import("batch_uname_error_response_item.zig").BatchUnameErrorResponseItem;
const BatchUnameSuccessResponseItem = @import("batch_uname_success_response_item.zig").BatchUnameSuccessResponseItem;

pub const BatchLookupUserUnameInput = struct {
    /// A unique identifier for this request to ensure idempotency.
    client_token: ?[]const u8 = null,

    /// The ID of the Wickr network where the users will be looked up.
    network_id: []const u8,

    /// A list of username hashes (unames) to look up. Each uname is a unique
    /// identifier for a user's username. Maximum 50 unames per batch request.
    unames: []const []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .network_id = "networkId",
        .unames = "unames",
    };
};

pub const BatchLookupUserUnameOutput = struct {
    /// A list of username hash lookup attempts that failed, including error details
    /// explaining why each lookup failed.
    failed: ?[]const BatchUnameErrorResponseItem = null,

    /// A message indicating the overall result of the batch lookup operation.
    message: ?[]const u8 = null,

    /// A list of successfully resolved username hashes with their corresponding
    /// email addresses.
    successful: ?[]const BatchUnameSuccessResponseItem = null,

    pub const json_field_names = .{
        .failed = "failed",
        .message = "message",
        .successful = "successful",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchLookupUserUnameInput, options: CallOptions) !BatchLookupUserUnameOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "wickr", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchLookupUserUnameInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("admin.wickr", "Wickr", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/networks/");
    try path_buf.appendSlice(allocator, input.network_id);
    try path_buf.appendSlice(allocator, "/users/uname-lookup");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"unames\":");
    try aws.json.writeValue(@TypeOf(input.unames), input.unames, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");
    if (input.client_token) |v| {
        try request.headers.put(allocator, "X-Client-Token", v);
    }

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchLookupUserUnameOutput {
    const result: BatchLookupUserUnameOutput = try aws.json.parseJsonObject(
        BatchLookupUserUnameOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
