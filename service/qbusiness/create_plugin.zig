const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PluginAuthConfiguration = @import("plugin_auth_configuration.zig").PluginAuthConfiguration;
const CustomPluginConfiguration = @import("custom_plugin_configuration.zig").CustomPluginConfiguration;
const Tag = @import("tag.zig").Tag;
const PluginType = @import("plugin_type.zig").PluginType;
const PluginBuildStatus = @import("plugin_build_status.zig").PluginBuildStatus;

pub const CreatePluginInput = struct {
    /// The identifier of the application that will contain the plugin.
    application_id: []const u8,

    auth_configuration: PluginAuthConfiguration,

    /// A token that you provide to identify the request to create your Amazon Q
    /// Business plugin.
    client_token: ?[]const u8 = null,

    /// Contains configuration for a custom plugin.
    custom_plugin_configuration: ?CustomPluginConfiguration = null,

    /// A the name for your plugin.
    display_name: []const u8,

    /// The source URL used for plugin configuration.
    server_url: ?[]const u8 = null,

    /// A list of key-value pairs that identify or categorize the data source
    /// connector. You can also use tags to help control access to the data source
    /// connector. Tag keys and values can consist of Unicode letters, digits, white
    /// space, and any of the following symbols: _ . : / = + - @.
    tags: ?[]const Tag = null,

    /// The type of plugin you want to create.
    @"type": PluginType,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .auth_configuration = "authConfiguration",
        .client_token = "clientToken",
        .custom_plugin_configuration = "customPluginConfiguration",
        .display_name = "displayName",
        .server_url = "serverUrl",
        .tags = "tags",
        .@"type" = "type",
    };
};

pub const CreatePluginOutput = struct {
    /// The current status of a plugin. A plugin is modified asynchronously.
    build_status: ?PluginBuildStatus = null,

    /// The Amazon Resource Name (ARN) of a plugin.
    plugin_arn: ?[]const u8 = null,

    /// The identifier of the plugin created.
    plugin_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .build_status = "buildStatus",
        .plugin_arn = "pluginArn",
        .plugin_id = "pluginId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreatePluginInput, options: CallOptions) !CreatePluginOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreatePluginInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("qbusiness", "QBusiness", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/applications/");
    try path_buf.appendSlice(allocator, input.application_id);
    try path_buf.appendSlice(allocator, "/plugins");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"authConfiguration\":");
    try aws.json.writeValue(@TypeOf(input.auth_configuration), input.auth_configuration, allocator, &body_buf);
    has_prev = true;
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.custom_plugin_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"customPluginConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"displayName\":");
    try aws.json.writeValue(@TypeOf(input.display_name), input.display_name, allocator, &body_buf);
    has_prev = true;
    if (input.server_url) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"serverUrl\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"type\":");
    try aws.json.writeValue(@TypeOf(input.@"type"), input.@"type", allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreatePluginOutput {
    var result: CreatePluginOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreatePluginOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
