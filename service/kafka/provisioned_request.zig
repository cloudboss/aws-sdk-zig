const BrokerNodeGroupInfo = @import("broker_node_group_info.zig").BrokerNodeGroupInfo;
const ClientAuthentication = @import("client_authentication.zig").ClientAuthentication;
const ConfigurationInfo = @import("configuration_info.zig").ConfigurationInfo;
const EncryptionInfo = @import("encryption_info.zig").EncryptionInfo;
const EnhancedMonitoring = @import("enhanced_monitoring.zig").EnhancedMonitoring;
const LoggingInfo = @import("logging_info.zig").LoggingInfo;
const OpenMonitoringInfo = @import("open_monitoring_info.zig").OpenMonitoringInfo;
const Rebalancing = @import("rebalancing.zig").Rebalancing;
const StorageMode = @import("storage_mode.zig").StorageMode;

/// Provisioned cluster request.
pub const ProvisionedRequest = struct {
    /// Information about the brokers.
    broker_node_group_info: BrokerNodeGroupInfo,

    /// Includes all client authentication information.
    client_authentication: ?ClientAuthentication,

    /// Represents the configuration that you want Amazon MSK to use for the brokers
    /// in a cluster.
    configuration_info: ?ConfigurationInfo,

    /// Includes all encryption-related information.
    encryption_info: ?EncryptionInfo,

    /// Specifies the level of monitoring for the MSK cluster. The possible values
    /// are DEFAULT, PER_BROKER, PER_TOPIC_PER_BROKER, and PER_TOPIC_PER_PARTITION.
    enhanced_monitoring: ?EnhancedMonitoring,

    /// The Apache Kafka version that you want for the cluster.
    kafka_version: []const u8,

    /// Log delivery information for the cluster.
    logging_info: ?LoggingInfo,

    /// The number of broker nodes in the cluster.
    number_of_broker_nodes: i32,

    /// The settings for open monitoring.
    open_monitoring: ?OpenMonitoringInfo,

    /// Specifies if intelligent rebalancing is turned on for your MSK Provisioned
    /// cluster with Express brokers. For all new Express-based clusters that you
    /// create, intelligent rebalancing is turned on by default.
    rebalancing: ?Rebalancing,

    /// This controls storage mode for supported storage tiers.
    storage_mode: ?StorageMode,

    pub const json_field_names = .{
        .broker_node_group_info = "BrokerNodeGroupInfo",
        .client_authentication = "ClientAuthentication",
        .configuration_info = "ConfigurationInfo",
        .encryption_info = "EncryptionInfo",
        .enhanced_monitoring = "EnhancedMonitoring",
        .kafka_version = "KafkaVersion",
        .logging_info = "LoggingInfo",
        .number_of_broker_nodes = "NumberOfBrokerNodes",
        .open_monitoring = "OpenMonitoring",
        .rebalancing = "Rebalancing",
        .storage_mode = "StorageMode",
    };
};
