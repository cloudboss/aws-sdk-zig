const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BatchCreateUserRequestItem = @import("batch_create_user_request_item.zig").BatchCreateUserRequestItem;
const BatchUserErrorResponseItem = @import("batch_user_error_response_item.zig").BatchUserErrorResponseItem;
const User = @import("user.zig").User;

pub const BatchCreateUserInput = struct {
    /// A unique identifier for this request to ensure idempotency. If you retry a
    /// request with the same client token, the service will return the same
    /// response without creating duplicate users.
    client_token: ?[]const u8 = null,

    /// The ID of the Wickr network where users will be created.
    network_id: []const u8,

    /// A list of user objects containing the details for each user to be created,
    /// including username, name, security groups, and optional invite codes.
    /// Maximum 50 users per batch request.
    users: []const BatchCreateUserRequestItem,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .network_id = "networkId",
        .users = "users",
    };
};

pub const BatchCreateUserOutput = struct {
    /// A list of user creation attempts that failed, including error details
    /// explaining why each user could not be created.
    failed: ?[]const BatchUserErrorResponseItem = null,

    /// A message indicating the overall result of the batch operation.
    message: ?[]const u8 = null,

    /// A list of user objects that were successfully created, including their
    /// assigned user IDs and invite codes.
    successful: ?[]const User = null,

    pub const json_field_names = .{
        .failed = "failed",
        .message = "message",
        .successful = "successful",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchCreateUserInput, options: CallOptions) !BatchCreateUserOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchCreateUserInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("admin.wickr", "Wickr", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/networks/");
    try path_buf.appendSlice(allocator, input.network_id);
    try path_buf.appendSlice(allocator, "/users");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"users\":");
    try aws.json.writeValue(@TypeOf(input.users), input.users, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchCreateUserOutput {
    var result: BatchCreateUserOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(BatchCreateUserOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
