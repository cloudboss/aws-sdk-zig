const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UpdateThemeData = @import("update_theme_data.zig").UpdateThemeData;
const Theme = @import("theme.zig").Theme;

pub const UpdateThemeInput = struct {
    /// The unique ID for the Amplify app.
    app_id: []const u8,

    /// The unique client token.
    client_token: ?[]const u8 = null,

    /// The name of the backend environment that is part of the Amplify app.
    environment_name: []const u8,

    /// The unique ID for the theme.
    id: []const u8,

    /// The configuration of the updated theme.
    updated_theme: UpdateThemeData,

    pub const json_field_names = .{
        .app_id = "appId",
        .client_token = "clientToken",
        .environment_name = "environmentName",
        .id = "id",
        .updated_theme = "updatedTheme",
    };
};

pub const UpdateThemeOutput = struct {
    /// Describes the configuration of the updated theme.
    entity: ?Theme = null,

    pub const json_field_names = .{
        .entity = "entity",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateThemeInput, options: CallOptions) !UpdateThemeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "amplifyuibuilder", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateThemeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("amplifyuibuilder", "AmplifyUIBuilder", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/app/");
    try path_buf.appendSlice(allocator, input.app_id);
    try path_buf.appendSlice(allocator, "/environment/");
    try path_buf.appendSlice(allocator, input.environment_name);
    try path_buf.appendSlice(allocator, "/themes/");
    try path_buf.appendSlice(allocator, input.id);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.client_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "clientToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body = try aws.json.jsonStringify(input.updated_theme, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateThemeOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateThemeOutput = .{};

    return result;
}
