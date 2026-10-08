const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PluginAuthConfiguration = @import("plugin_auth_configuration.zig").PluginAuthConfiguration;
const CustomPluginConfiguration = @import("custom_plugin_configuration.zig").CustomPluginConfiguration;
const PluginState = @import("plugin_state.zig").PluginState;

pub const UpdatePluginInput = struct {
    /// The identifier of the application the plugin is attached to.
    application_id: []const u8,

    /// The authentication configuration the plugin is using.
    auth_configuration: ?PluginAuthConfiguration = null,

    /// The configuration for a custom plugin.
    custom_plugin_configuration: ?CustomPluginConfiguration = null,

    /// The name of the plugin.
    display_name: ?[]const u8 = null,

    /// The identifier of the plugin.
    plugin_id: []const u8,

    /// The source URL used for plugin configuration.
    server_url: ?[]const u8 = null,

    /// The status of the plugin.
    state: ?PluginState = null,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .auth_configuration = "authConfiguration",
        .custom_plugin_configuration = "customPluginConfiguration",
        .display_name = "displayName",
        .plugin_id = "pluginId",
        .server_url = "serverUrl",
        .state = "state",
    };
};

pub const UpdatePluginOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdatePluginInput, options: CallOptions) !UpdatePluginOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdatePluginInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("qbusiness", "QBusiness", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/applications/");
    try path_buf.appendSlice(allocator, input.application_id);
    try path_buf.appendSlice(allocator, "/plugins/");
    try path_buf.appendSlice(allocator, input.plugin_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.auth_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"authConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.custom_plugin_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"customPluginConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.display_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"displayName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.server_url) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"serverUrl\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.state) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"state\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdatePluginOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdatePluginOutput = .{};

    return result;
}
