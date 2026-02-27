const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const CapacityDescription = @import("capacity_description.zig").CapacityDescription;
const ConnectorState = @import("connector_state.zig").ConnectorState;
const KafkaClusterDescription = @import("kafka_cluster_description.zig").KafkaClusterDescription;
const KafkaClusterClientAuthenticationDescription = @import("kafka_cluster_client_authentication_description.zig").KafkaClusterClientAuthenticationDescription;
const KafkaClusterEncryptionInTransitDescription = @import("kafka_cluster_encryption_in_transit_description.zig").KafkaClusterEncryptionInTransitDescription;
const LogDeliveryDescription = @import("log_delivery_description.zig").LogDeliveryDescription;
const NetworkType = @import("network_type.zig").NetworkType;
const PluginDescription = @import("plugin_description.zig").PluginDescription;
const StateDescription = @import("state_description.zig").StateDescription;
const WorkerConfigurationDescription = @import("worker_configuration_description.zig").WorkerConfigurationDescription;

pub const DescribeConnectorInput = struct {
    /// The Amazon Resource Name (ARN) of the connector that you want to describe.
    connector_arn: []const u8,

    pub const json_field_names = .{
        .connector_arn = "connectorArn",
    };
};

pub const DescribeConnectorOutput = struct {
    /// Information about the capacity of the connector, whether it is auto scaled
    /// or provisioned.
    capacity: ?CapacityDescription = null,

    /// The Amazon Resource Name (ARN) of the connector.
    connector_arn: ?[]const u8 = null,

    /// A map of keys to values that represent the configuration for the connector.
    connector_configuration: ?[]const aws.map.StringMapEntry = null,

    /// A summary description of the connector.
    connector_description: ?[]const u8 = null,

    /// The name of the connector.
    connector_name: ?[]const u8 = null,

    /// The state of the connector.
    connector_state: ?ConnectorState = null,

    /// The time the connector was created.
    creation_time: ?i64 = null,

    /// The current version of the connector.
    current_version: ?[]const u8 = null,

    /// The Apache Kafka cluster that the connector is connected to.
    kafka_cluster: ?KafkaClusterDescription = null,

    /// The type of client authentication used to connect to the Apache Kafka
    /// cluster. The value is NONE when no client authentication is used.
    kafka_cluster_client_authentication: ?KafkaClusterClientAuthenticationDescription = null,

    /// Details of encryption in transit to the Apache Kafka cluster.
    kafka_cluster_encryption_in_transit: ?KafkaClusterEncryptionInTransitDescription = null,

    /// The version of Kafka Connect. It has to be compatible with both the Apache
    /// Kafka cluster's version and the plugins.
    kafka_connect_version: ?[]const u8 = null,

    /// Details about delivering logs to Amazon CloudWatch Logs.
    log_delivery: ?LogDeliveryDescription = null,

    /// The network type of the connector. It gives connectors connectivity to
    /// either IPv4 (IPV4) or IPv4 and IPv6 (DUAL) destinations. Defaults to IPV4.
    network_type: ?NetworkType = null,

    /// Specifies which plugins were used for this connector.
    plugins: ?[]const PluginDescription = null,

    /// The Amazon Resource Name (ARN) of the IAM role used by the connector to
    /// access Amazon Web Services resources.
    service_execution_role_arn: ?[]const u8 = null,

    /// Details about the state of a connector.
    state_description: ?StateDescription = null,

    /// Specifies which worker configuration was used for the connector.
    worker_configuration: ?WorkerConfigurationDescription = null,

    pub const json_field_names = .{
        .capacity = "capacity",
        .connector_arn = "connectorArn",
        .connector_configuration = "connectorConfiguration",
        .connector_description = "connectorDescription",
        .connector_name = "connectorName",
        .connector_state = "connectorState",
        .creation_time = "creationTime",
        .current_version = "currentVersion",
        .kafka_cluster = "kafkaCluster",
        .kafka_cluster_client_authentication = "kafkaClusterClientAuthentication",
        .kafka_cluster_encryption_in_transit = "kafkaClusterEncryptionInTransit",
        .kafka_connect_version = "kafkaConnectVersion",
        .log_delivery = "logDelivery",
        .network_type = "networkType",
        .plugins = "plugins",
        .service_execution_role_arn = "serviceExecutionRoleArn",
        .state_description = "stateDescription",
        .worker_configuration = "workerConfiguration",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeConnectorInput, options: Options) !DescribeConnectorOutput {
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: DescribeConnectorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kafkaconnect", "KafkaConnect", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/v1/connectors/");
    try path_buf.appendSlice(alloc, input.connector_arn);
    const path = try path_buf.toOwnedSlice(alloc);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !DescribeConnectorOutput {
    var result: DescribeConnectorOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeConnectorOutput, body, alloc);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
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
