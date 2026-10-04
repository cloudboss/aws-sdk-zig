const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LoginAuthConfigReqObj = @import("login_auth_config_req_obj.zig").LoginAuthConfigReqObj;

pub const UpdateBackendConfigInput = struct {
    /// The app ID.
    app_id: []const u8,

    /// Describes the Amazon Cognito configuration for Admin UI access.
    login_auth_config: ?LoginAuthConfigReqObj = null,

    pub const json_field_names = .{
        .app_id = "AppId",
        .login_auth_config = "LoginAuthConfig",
    };
};

pub const UpdateBackendConfigOutput = struct {
    /// The app ID.
    app_id: ?[]const u8 = null,

    /// The app ID for the backend manager.
    backend_manager_app_id: ?[]const u8 = null,

    /// If the request fails, this error is returned.
    @"error": ?[]const u8 = null,

    /// Describes the Amazon Cognito configurations for the Admin UI auth resource
    /// to log in with.
    login_auth_config: ?LoginAuthConfigReqObj = null,

    pub const json_field_names = .{
        .app_id = "AppId",
        .backend_manager_app_id = "BackendManagerAppId",
        .@"error" = "Error",
        .login_auth_config = "LoginAuthConfig",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateBackendConfigInput, options: CallOptions) !UpdateBackendConfigOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "amplifybackend", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateBackendConfigInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("amplifybackend", "AmplifyBackend", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/backend/");
    try path_buf.appendSlice(allocator, input.app_id);
    try path_buf.appendSlice(allocator, "/config/update");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.login_auth_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"LoginAuthConfig\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateBackendConfigOutput {
    var result: UpdateBackendConfigOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateBackendConfigOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
