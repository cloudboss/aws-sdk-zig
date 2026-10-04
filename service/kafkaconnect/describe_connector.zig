const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeConnectorInput, options: CallOptions) !DescribeConnectorOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeConnectorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kafkaconnect", "KafkaConnect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/connectors/");
    try path_buf.appendSlice(allocator, input.connector_arn);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeConnectorOutput {
    const result: DescribeConnectorOutput = try aws.json.parseJsonObject(
        DescribeConnectorOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
