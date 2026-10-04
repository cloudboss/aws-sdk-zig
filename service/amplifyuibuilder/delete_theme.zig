const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeleteThemeInput = struct {
    /// The unique ID of the Amplify app associated with the theme to
    /// delete.
    app_id: []const u8,

    /// The name of the backend environment that is a part of the Amplify
    /// app.
    environment_name: []const u8,

    /// The unique ID of the theme to delete.
    id: []const u8,

    pub const json_field_names = .{
        .app_id = "appId",
        .environment_name = "environmentName",
        .id = "id",
    };
};

pub const DeleteThemeOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteThemeInput, options: CallOptions) !DeleteThemeOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteThemeInput, config: *aws.Config) !aws.http.Request {
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

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteThemeOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: DeleteThemeOutput = .{};

    return result;
}
