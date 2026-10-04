const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const AssociateUserToPermissionGroupInput = struct {
    /// A token that ensures idempotency. This token expires in 10 minutes.
    client_token: ?[]const u8 = null,

    /// The unique identifier for the permission group.
    permission_group_id: []const u8,

    /// The unique identifier for the user.
    user_id: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .permission_group_id = "permissionGroupId",
        .user_id = "userId",
    };
};

pub const AssociateUserToPermissionGroupOutput = struct {
    /// The returned status code of the response.
    status_code: ?i32 = null,

    pub const json_field_names = .{
        .status_code = "statusCode",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AssociateUserToPermissionGroupInput, options: CallOptions) !AssociateUserToPermissionGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "finspace-api", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: AssociateUserToPermissionGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("finspace-api", "finspace data", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/permission-group/");
    try path_buf.appendSlice(allocator, input.permission_group_id);
    try path_buf.appendSlice(allocator, "/users/");
    try path_buf.appendSlice(allocator, input.user_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AssociateUserToPermissionGroupOutput {
    _ = allocator;
    var result: AssociateUserToPermissionGroupOutput = .{};
    _ = body;
    result.status_code = @intCast(status);
    _ = headers;

    return result;
}
