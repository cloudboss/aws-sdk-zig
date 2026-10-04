const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UserAccessLoggingSettings = @import("user_access_logging_settings.zig").UserAccessLoggingSettings;

pub const GetUserAccessLoggingSettingsInput = struct {
    /// The ARN of the user access logging settings.
    user_access_logging_settings_arn: []const u8,

    pub const json_field_names = .{
        .user_access_logging_settings_arn = "userAccessLoggingSettingsArn",
    };
};

pub const GetUserAccessLoggingSettingsOutput = struct {
    /// The user access logging settings.
    user_access_logging_settings: ?UserAccessLoggingSettings = null,

    pub const json_field_names = .{
        .user_access_logging_settings = "userAccessLoggingSettings",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetUserAccessLoggingSettingsInput, options: CallOptions) !GetUserAccessLoggingSettingsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "workspaces-web", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetUserAccessLoggingSettingsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("workspaces-web", "WorkSpaces Web", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/userAccessLoggingSettings/");
    try path_buf.appendSlice(allocator, input.user_access_logging_settings_arn);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetUserAccessLoggingSettingsOutput {
    var result: GetUserAccessLoggingSettingsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetUserAccessLoggingSettingsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
