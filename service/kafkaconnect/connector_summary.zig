const CapacityDescription = @import("capacity_description.zig").CapacityDescription;
const ConnectorState = @import("connector_state.zig").ConnectorState;
const KafkaClusterDescription = @import("kafka_cluster_description.zig").KafkaClusterDescription;
const KafkaClusterClientAuthenticationDescription = @import("kafka_cluster_client_authentication_description.zig").KafkaClusterClientAuthenticationDescription;
const KafkaClusterEncryptionInTransitDescription = @import("kafka_cluster_encryption_in_transit_description.zig").KafkaClusterEncryptionInTransitDescription;
const LogDeliveryDescription = @import("log_delivery_description.zig").LogDeliveryDescription;
const NetworkType = @import("network_type.zig").NetworkType;
const PluginDescription = @import("plugin_description.zig").PluginDescription;
const WorkerConfigurationDescription = @import("worker_configuration_description.zig").WorkerConfigurationDescription;

/// Summary of a connector.
pub const ConnectorSummary = struct {
    /// The connector's compute capacity settings.
    capacity: ?CapacityDescription = null,

    /// The Amazon Resource Name (ARN) of the connector.
    connector_arn: ?[]const u8 = null,

    /// The description of the connector.
    connector_description: ?[]const u8 = null,

    /// The name of the connector.
    connector_name: ?[]const u8 = null,

    /// The state of the connector.
    connector_state: ?ConnectorState = null,

    /// The time that the connector was created.
    creation_time: ?i64 = null,

    /// The current version of the connector.
    current_version: ?[]const u8 = null,

    /// The details of the Apache Kafka cluster to which the connector is connected.
    kafka_cluster: ?KafkaClusterDescription = null,

    /// The type of client authentication used to connect to the Apache Kafka
    /// cluster. The value is NONE when no client authentication is used.
    kafka_cluster_client_authentication: ?KafkaClusterClientAuthenticationDescription = null,

    /// Details of encryption in transit to the Apache Kafka cluster.
    kafka_cluster_encryption_in_transit: ?KafkaClusterEncryptionInTransitDescription = null,

    /// The version of Kafka Connect. It has to be compatible with both the Apache
    /// Kafka cluster's version and the plugins.
    kafka_connect_version: ?[]const u8 = null,

    /// The settings for delivering connector logs to Amazon CloudWatch Logs.
    log_delivery: ?LogDeliveryDescription = null,

    /// The network type of the connector. It gives connectors connectivity to
    /// either IPv4 (IPV4) or IPv4 and IPv6 (DUAL) destinations. Defaults to IPV4.
    network_type: ?NetworkType = null,

    /// Specifies which plugins were used for this connector.
    plugins: ?[]const PluginDescription = null,

    /// The Amazon Resource Name (ARN) of the IAM role used by the connector to
    /// access Amazon Web Services resources.
    service_execution_role_arn: ?[]const u8 = null,

    /// The worker configurations that are in use with the connector.
    worker_configuration: ?WorkerConfigurationDescription = null,

    pub const json_field_names = .{
        .capacity = "capacity",
        .connector_arn = "connectorArn",
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
        .worker_configuration = "workerConfiguration",
    };
};
