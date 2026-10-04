const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AuthenticationStrategy = @import("authentication_strategy.zig").AuthenticationStrategy;
const EngineType = @import("engine_type.zig").EngineType;
const ConfigurationRevision = @import("configuration_revision.zig").ConfigurationRevision;

pub const CreateConfigurationInput = struct {
    /// Optional. The authentication strategy associated with the configuration. The
    /// default is SIMPLE.
    authentication_strategy: ?AuthenticationStrategy = null,

    /// Required. The type of broker engine. Currently, Amazon MQ supports ACTIVEMQ
    /// and RABBITMQ.
    engine_type: EngineType,

    /// The broker engine version. Defaults to the latest available version for the
    /// specified broker engine type. For more information, see the [ActiveMQ
    /// version
    /// management](https://docs.aws.amazon.com//amazon-mq/latest/developer-guide/activemq-version-management.html) and the [RabbitMQ version management](https://docs.aws.amazon.com//amazon-mq/latest/developer-guide/rabbitmq-version-management.html) sections in the Amazon MQ Developer Guide.
    engine_version: ?[]const u8 = null,

    /// Required. The name of the configuration. This value can contain only
    /// alphanumeric characters, dashes, periods, underscores, and tildes (- . _ ~).
    /// This value must be 1-150 characters long.
    name: []const u8,

    /// Create tags when creating the configuration.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .authentication_strategy = "AuthenticationStrategy",
        .engine_type = "EngineType",
        .engine_version = "EngineVersion",
        .name = "Name",
        .tags = "Tags",
    };
};

pub const CreateConfigurationOutput = struct {
    /// Required. The Amazon Resource Name (ARN) of the configuration.
    arn: ?[]const u8 = null,

    /// Optional. The authentication strategy associated with the configuration. The
    /// default is SIMPLE.
    authentication_strategy: ?AuthenticationStrategy = null,

    /// Required. The date and time of the configuration.
    created: ?i64 = null,

    /// Required. The unique ID that Amazon MQ generates for the configuration.
    id: ?[]const u8 = null,

    /// The latest revision of the configuration.
    latest_revision: ?ConfigurationRevision = null,

    /// Required. The name of the configuration. This value can contain only
    /// alphanumeric characters, dashes, periods, underscores, and tildes (- . _ ~).
    /// This value must be 1-150 characters long.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .authentication_strategy = "AuthenticationStrategy",
        .created = "Created",
        .id = "Id",
        .latest_revision = "LatestRevision",
        .name = "Name",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateConfigurationInput, options: CallOptions) !CreateConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "mq", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mq", "mq", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/configurations";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.authentication_strategy) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AuthenticationStrategy\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"EngineType\":");
    try aws.json.writeValue(@TypeOf(input.engine_type), input.engine_type, allocator, &body_buf);
    has_prev = true;
    if (input.engine_version) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"EngineVersion\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateConfigurationOutput {
    const result: CreateConfigurationOutput = try aws.json.parseJsonObject(
        CreateConfigurationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
