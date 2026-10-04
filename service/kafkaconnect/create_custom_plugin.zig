const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CustomPluginContentType = @import("custom_plugin_content_type.zig").CustomPluginContentType;
const CustomPluginLocation = @import("custom_plugin_location.zig").CustomPluginLocation;
const CustomPluginState = @import("custom_plugin_state.zig").CustomPluginState;

pub const CreateCustomPluginInput = struct {
    /// The type of the plugin file.
    content_type: CustomPluginContentType,

    /// A summary description of the custom plugin.
    description: ?[]const u8 = null,

    /// Information about the location of a custom plugin.
    location: CustomPluginLocation,

    /// The name of the custom plugin.
    name: []const u8,

    /// The tags you want to attach to the custom plugin.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .content_type = "contentType",
        .description = "description",
        .location = "location",
        .name = "name",
        .tags = "tags",
    };
};

pub const CreateCustomPluginOutput = struct {
    /// The Amazon Resource Name (ARN) that Amazon assigned to the custom plugin.
    custom_plugin_arn: ?[]const u8 = null,

    /// The state of the custom plugin.
    custom_plugin_state: ?CustomPluginState = null,

    /// The name of the custom plugin.
    name: ?[]const u8 = null,

    /// The revision of the custom plugin.
    revision: ?i64 = null,

    pub const json_field_names = .{
        .custom_plugin_arn = "customPluginArn",
        .custom_plugin_state = "customPluginState",
        .name = "name",
        .revision = "revision",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateCustomPluginInput, options: CallOptions) !CreateCustomPluginOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "kafkaconnect", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateCustomPluginInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kafkaconnect", "KafkaConnect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/custom-plugins";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"contentType\":");
    try aws.json.writeValue(@TypeOf(input.content_type), input.content_type, allocator, &body_buf);
    has_prev = true;
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"location\":");
    try aws.json.writeValue(@TypeOf(input.location), input.location, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateCustomPluginOutput {
    var result: CreateCustomPluginOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateCustomPluginOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
