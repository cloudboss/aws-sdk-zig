const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UserAccessTaskItem = @import("user_access_task_item.zig").UserAccessTaskItem;

pub const StartUserAccessTasksInput = struct {
    /// The Amazon Resource Name (ARN) or Universal Unique Identifier (UUID) of the
    /// app bundle
    /// to use for the request.
    app_bundle_identifier: []const u8,

    /// The email address of the target user.
    email: []const u8,

    pub const json_field_names = .{
        .app_bundle_identifier = "appBundleIdentifier",
        .email = "email",
    };
};

pub const StartUserAccessTasksOutput = struct {
    /// Contains a list of user access task information.
    user_access_tasks_list: ?[]const UserAccessTaskItem = null,

    pub const json_field_names = .{
        .user_access_tasks_list = "userAccessTasksList",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartUserAccessTasksInput, options: CallOptions) !StartUserAccessTasksOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "appfabric", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartUserAccessTasksInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appfabric", "AppFabric", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/useraccess/start";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"appBundleIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.app_bundle_identifier), input.app_bundle_identifier, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"email\":");
    try aws.json.writeValue(@TypeOf(input.email), input.email, allocator, &body_buf);
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

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartUserAccessTasksOutput {
    var result: StartUserAccessTasksOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StartUserAccessTasksOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
