const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const HandlerConfigs = @import("handler_configs.zig").HandlerConfigs;
const AuthMode = @import("auth_mode.zig").AuthMode;
const ChannelNamespace = @import("channel_namespace.zig").ChannelNamespace;

pub const CreateChannelNamespaceInput = struct {
    /// The `Api` ID.
    api_id: []const u8,

    /// The event handler functions that run custom business logic to process
    /// published events
    /// and subscribe requests.
    code_handlers: ?[]const u8 = null,

    /// The configuration for the `OnPublish` and `OnSubscribe` handlers.
    handler_configs: ?HandlerConfigs = null,

    /// The name of the `ChannelNamespace`. This name must be unique within the
    /// `Api`
    name: []const u8,

    /// The authorization mode to use for publishing messages on the channel
    /// namespace. This
    /// configuration overrides the default `Api` authorization configuration.
    publish_auth_modes: ?[]const AuthMode = null,

    /// The authorization mode to use for subscribing to messages on the channel
    /// namespace. This
    /// configuration overrides the default `Api` authorization configuration.
    subscribe_auth_modes: ?[]const AuthMode = null,

    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .api_id = "apiId",
        .code_handlers = "codeHandlers",
        .handler_configs = "handlerConfigs",
        .name = "name",
        .publish_auth_modes = "publishAuthModes",
        .subscribe_auth_modes = "subscribeAuthModes",
        .tags = "tags",
    };
};

pub const CreateChannelNamespaceOutput = struct {
    /// The `ChannelNamespace` object.
    channel_namespace: ?ChannelNamespace = null,

    pub const json_field_names = .{
        .channel_namespace = "channelNamespace",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateChannelNamespaceInput, options: CallOptions) !CreateChannelNamespaceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "appsync", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateChannelNamespaceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appsync", "AppSync", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/apis/");
    try path_buf.appendSlice(allocator, input.api_id);
    try path_buf.appendSlice(allocator, "/channelNamespaces");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.code_handlers) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"codeHandlers\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.handler_configs) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"handlerConfigs\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.publish_auth_modes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"publishAuthModes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.subscribe_auth_modes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"subscribeAuthModes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateChannelNamespaceOutput {
    var result: CreateChannelNamespaceOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateChannelNamespaceOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
