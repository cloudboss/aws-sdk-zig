const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AuthenticationStrategy = @import("authentication_strategy.zig").AuthenticationStrategy;
const EngineType = @import("engine_type.zig").EngineType;
const ConfigurationRevision = @import("configuration_revision.zig").ConfigurationRevision;

pub const DescribeConfigurationInput = struct {
    /// The unique ID that Amazon MQ generates for the configuration.
    configuration_id: []const u8,

    pub const json_field_names = .{
        .configuration_id = "ConfigurationId",
    };
};

pub const DescribeConfigurationOutput = struct {
    /// Required. The ARN of the configuration.
    arn: ?[]const u8 = null,

    /// Optional. The authentication strategy associated with the configuration. The
    /// default is SIMPLE.
    authentication_strategy: ?AuthenticationStrategy = null,

    /// Required. The date and time of the configuration revision.
    created: ?i64 = null,

    /// Required. The description of the configuration.
    description: ?[]const u8 = null,

    /// Required. The type of broker engine. Currently, Amazon MQ supports ACTIVEMQ
    /// and RABBITMQ.
    engine_type: ?EngineType = null,

    /// The broker engine version. Defaults to the latest available version for the
    /// specified broker engine type. For a list of supported engine versions, see
    /// the [ActiveMQ version
    /// management](https://docs.aws.amazon.com//amazon-mq/latest/developer-guide/activemq-version-management.html) and the [RabbitMQ version management](https://docs.aws.amazon.com//amazon-mq/latest/developer-guide/rabbitmq-version-management.html) sections in the Amazon MQ Developer Guide.
    engine_version: ?[]const u8 = null,

    /// Required. The unique ID that Amazon MQ generates for the configuration.
    id: ?[]const u8 = null,

    /// Required. The latest revision of the configuration.
    latest_revision: ?ConfigurationRevision = null,

    /// Required. The name of the configuration. This value can contain only
    /// alphanumeric characters, dashes, periods, underscores, and tildes (- . _ ~).
    /// This value must be 1-150 characters long.
    name: ?[]const u8 = null,

    /// The list of all tags associated with this configuration.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .authentication_strategy = "AuthenticationStrategy",
        .created = "Created",
        .description = "Description",
        .engine_type = "EngineType",
        .engine_version = "EngineVersion",
        .id = "Id",
        .latest_revision = "LatestRevision",
        .name = "Name",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeConfigurationInput, options: CallOptions) !DescribeConfigurationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mq", "mq", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/configurations/");
    try path_buf.appendSlice(allocator, input.configuration_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeConfigurationOutput {
    const result: DescribeConfigurationOutput = try aws.json.parseJsonObject(
        DescribeConfigurationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
