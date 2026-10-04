const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConfigurationRevision = @import("configuration_revision.zig").ConfigurationRevision;
const ConfigurationState = @import("configuration_state.zig").ConfigurationState;

pub const CreateConfigurationInput = struct {
    /// The description of the configuration.
    description: ?[]const u8 = null,

    /// The versions of Apache Kafka with which you can use this MSK configuration.
    kafka_versions: ?[]const []const u8 = null,

    /// The name of the configuration.
    name: []const u8,

    /// Contents of the server.properties file. When using the API, you must ensure
    /// that the contents of the file are base64 encoded.
    /// When using the AWS Management Console, the SDK, or the AWS CLI, the contents
    /// of server.properties can be in plaintext.
    server_properties: []const u8,

    pub const json_field_names = .{
        .description = "Description",
        .kafka_versions = "KafkaVersions",
        .name = "Name",
        .server_properties = "ServerProperties",
    };
};

pub const CreateConfigurationOutput = struct {
    /// The Amazon Resource Name (ARN) of the configuration.
    arn: ?[]const u8 = null,

    /// The time when the configuration was created.
    creation_time: ?i64 = null,

    /// Latest revision of the configuration.
    latest_revision: ?ConfigurationRevision = null,

    /// The name of the configuration.
    name: ?[]const u8 = null,

    /// The state of the configuration. The possible states are ACTIVE, DELETING,
    /// and DELETE_FAILED.
    state: ?ConfigurationState = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .creation_time = "CreationTime",
        .latest_revision = "LatestRevision",
        .name = "Name",
        .state = "State",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateConfigurationInput, options: CallOptions) !CreateConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "kafka", client.config.http_client.clock_skew_offset);

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
    const endpoint = try config.getEndpointForService("kafka", "Kafka", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/configurations";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.kafka_versions) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"KafkaVersions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ServerProperties\":");
    try aws.json.writeValue(@TypeOf(input.server_properties), input.server_properties, allocator, &body_buf);
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
