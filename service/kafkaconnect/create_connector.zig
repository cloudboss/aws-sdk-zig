const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const Capacity = @import("capacity.zig").Capacity;
const KafkaCluster = @import("kafka_cluster.zig").KafkaCluster;
const KafkaClusterClientAuthentication = @import("kafka_cluster_client_authentication.zig").KafkaClusterClientAuthentication;
const KafkaClusterEncryptionInTransit = @import("kafka_cluster_encryption_in_transit.zig").KafkaClusterEncryptionInTransit;
const LogDelivery = @import("log_delivery.zig").LogDelivery;
const NetworkType = @import("network_type.zig").NetworkType;
const Plugin = @import("plugin.zig").Plugin;
const WorkerConfiguration = @import("worker_configuration.zig").WorkerConfiguration;
const ConnectorState = @import("connector_state.zig").ConnectorState;

pub const CreateConnectorInput = struct {
    /// Information about the capacity allocated to the connector. Exactly one of
    /// the two properties must be specified.
    capacity: Capacity,

    /// A map of keys to values that represent the configuration for the connector.
    connector_configuration: []const aws.map.StringMapEntry,

    /// A summary description of the connector.
    connector_description: ?[]const u8 = null,

    /// The name of the connector.
    connector_name: []const u8,

    /// Specifies which Apache Kafka cluster to connect to.
    kafka_cluster: KafkaCluster,

    /// Details of the client authentication used by the Apache Kafka cluster.
    kafka_cluster_client_authentication: KafkaClusterClientAuthentication,

    /// Details of encryption in transit to the Apache Kafka cluster.
    kafka_cluster_encryption_in_transit: KafkaClusterEncryptionInTransit,

    /// The version of Kafka Connect. It has to be compatible with both the Apache
    /// Kafka cluster's version and the plugins.
    kafka_connect_version: []const u8,

    /// Details about log delivery.
    log_delivery: ?LogDelivery = null,

    /// The network type of the connector. It gives connectors connectivity to
    /// either IPv4 (IPV4) or IPv4 and IPv6 (DUAL) destinations. Defaults to IPV4.
    network_type: ?NetworkType = null,

    /// Amazon MSK Connect does not currently support specifying multiple plugins as
    /// a list. To use more than one plugin for your connector, you can create a
    /// single custom plugin using a ZIP file that bundles multiple plugins
    /// together.
    ///
    /// Specifies which plugin to use for the connector. You must specify a
    /// single-element list containing one `customPlugin` object.
    plugins: []const Plugin,

    /// The Amazon Resource Name (ARN) of the IAM role used by the connector to
    /// access the Amazon Web Services resources that it needs. The types of
    /// resources depends on the logic of the connector. For example, a connector
    /// that has Amazon S3 as a destination must have permissions that allow it to
    /// write to the S3 destination bucket.
    service_execution_role_arn: []const u8,

    /// The tags you want to attach to the connector.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// Specifies which worker configuration to use with the connector.
    worker_configuration: ?WorkerConfiguration = null,

    pub const json_field_names = .{
        .capacity = "capacity",
        .connector_configuration = "connectorConfiguration",
        .connector_description = "connectorDescription",
        .connector_name = "connectorName",
        .kafka_cluster = "kafkaCluster",
        .kafka_cluster_client_authentication = "kafkaClusterClientAuthentication",
        .kafka_cluster_encryption_in_transit = "kafkaClusterEncryptionInTransit",
        .kafka_connect_version = "kafkaConnectVersion",
        .log_delivery = "logDelivery",
        .network_type = "networkType",
        .plugins = "plugins",
        .service_execution_role_arn = "serviceExecutionRoleArn",
        .tags = "tags",
        .worker_configuration = "workerConfiguration",
    };
};

pub const CreateConnectorOutput = struct {
    /// The Amazon Resource Name (ARN) that Amazon assigned to the connector.
    connector_arn: ?[]const u8 = null,

    /// The name of the connector.
    connector_name: ?[]const u8 = null,

    /// The state of the connector.
    connector_state: ?ConnectorState = null,

    pub const json_field_names = .{
        .connector_arn = "connectorArn",
        .connector_name = "connectorName",
        .connector_state = "connectorState",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateConnectorInput, options: CallOptions) !CreateConnectorOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "kafkaconnect");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateConnectorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kafkaconnect", "KafkaConnect", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/v1/connectors";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"capacity\":");
    try aws.json.writeValue(@TypeOf(input.capacity), input.capacity, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"connectorConfiguration\":");
    try aws.json.writeValue(@TypeOf(input.connector_configuration), input.connector_configuration, allocator, &body_buf);
    has_prev = true;
    if (input.connector_description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"connectorDescription\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"connectorName\":");
    try aws.json.writeValue(@TypeOf(input.connector_name), input.connector_name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"kafkaCluster\":");
    try aws.json.writeValue(@TypeOf(input.kafka_cluster), input.kafka_cluster, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"kafkaClusterClientAuthentication\":");
    try aws.json.writeValue(@TypeOf(input.kafka_cluster_client_authentication), input.kafka_cluster_client_authentication, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"kafkaClusterEncryptionInTransit\":");
    try aws.json.writeValue(@TypeOf(input.kafka_cluster_encryption_in_transit), input.kafka_cluster_encryption_in_transit, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"kafkaConnectVersion\":");
    try aws.json.writeValue(@TypeOf(input.kafka_connect_version), input.kafka_connect_version, allocator, &body_buf);
    has_prev = true;
    if (input.log_delivery) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"logDelivery\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.network_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"networkType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"plugins\":");
    try aws.json.writeValue(@TypeOf(input.plugins), input.plugins, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"serviceExecutionRoleArn\":");
    try aws.json.writeValue(@TypeOf(input.service_execution_role_arn), input.service_execution_role_arn, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.worker_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"workerConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateConnectorOutput {
    var result: CreateConnectorOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateConnectorOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ForbiddenException")) {
        return .{ .arena = arena, .kind = .{ .forbidden_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerErrorException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_error_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyRequestsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_requests_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnauthorizedException")) {
        return .{ .arena = arena, .kind = .{ .unauthorized_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
