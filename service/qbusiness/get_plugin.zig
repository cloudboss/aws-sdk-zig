const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PluginAuthConfiguration = @import("plugin_auth_configuration.zig").PluginAuthConfiguration;
const PluginBuildStatus = @import("plugin_build_status.zig").PluginBuildStatus;
const CustomPluginConfiguration = @import("custom_plugin_configuration.zig").CustomPluginConfiguration;
const PluginState = @import("plugin_state.zig").PluginState;
const PluginType = @import("plugin_type.zig").PluginType;

pub const GetPluginInput = struct {
    /// The identifier of the application which contains the plugin.
    application_id: []const u8,

    /// The identifier of the plugin.
    plugin_id: []const u8,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .plugin_id = "pluginId",
    };
};

pub const GetPluginOutput = struct {
    /// The identifier of the application which contains the plugin.
    application_id: ?[]const u8 = null,

    auth_configuration: ?PluginAuthConfiguration = null,

    /// The current status of a plugin. A plugin is modified asynchronously.
    build_status: ?PluginBuildStatus = null,

    /// The timestamp for when the plugin was created.
    created_at: ?i64 = null,

    /// Configuration information required to create a custom plugin.
    custom_plugin_configuration: ?CustomPluginConfiguration = null,

    /// The name of the plugin.
    display_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the role with permission to access
    /// resources needed to create the plugin.
    plugin_arn: ?[]const u8 = null,

    /// The identifier of the plugin.
    plugin_id: ?[]const u8 = null,

    /// The source URL used for plugin configuration.
    server_url: ?[]const u8 = null,

    /// The current state of the plugin.
    state: ?PluginState = null,

    /// The type of the plugin.
    @"type": ?PluginType = null,

    /// The timestamp for when the plugin was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .auth_configuration = "authConfiguration",
        .build_status = "buildStatus",
        .created_at = "createdAt",
        .custom_plugin_configuration = "customPluginConfiguration",
        .display_name = "displayName",
        .plugin_arn = "pluginArn",
        .plugin_id = "pluginId",
        .server_url = "serverUrl",
        .state = "state",
        .@"type" = "type",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetPluginInput, options: CallOptions) !GetPluginOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "qbusiness", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetPluginInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("qbusiness", "QBusiness", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/applications/");
    try path_buf.appendSlice(allocator, input.application_id);
    try path_buf.appendSlice(allocator, "/plugins/");
    try path_buf.appendSlice(allocator, input.plugin_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetPluginOutput {
    const result: GetPluginOutput = try aws.json.parseJsonObject(
        GetPluginOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
