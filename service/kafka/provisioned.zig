const BrokerNodeGroupInfo = @import("broker_node_group_info.zig").BrokerNodeGroupInfo;
const ClientAuthentication = @import("client_authentication.zig").ClientAuthentication;
const BrokerSoftwareInfo = @import("broker_software_info.zig").BrokerSoftwareInfo;
const CustomerActionStatus = @import("customer_action_status.zig").CustomerActionStatus;
const EncryptionInfo = @import("encryption_info.zig").EncryptionInfo;
const EnhancedMonitoring = @import("enhanced_monitoring.zig").EnhancedMonitoring;
const LoggingInfo = @import("logging_info.zig").LoggingInfo;
const OpenMonitoringInfo = @import("open_monitoring_info.zig").OpenMonitoringInfo;
const Rebalancing = @import("rebalancing.zig").Rebalancing;
const StorageMode = @import("storage_mode.zig").StorageMode;

/// Provisioned cluster.
pub const Provisioned = struct {
    /// Information about the brokers.
    broker_node_group_info: BrokerNodeGroupInfo,

    /// Includes all client authentication information.
    client_authentication: ?ClientAuthentication = null,

    /// Information about the Apache Kafka version deployed on the brokers.
    current_broker_software_info: ?BrokerSoftwareInfo = null,

    /// Determines if there is an action required from the customer.
    customer_action_status: ?CustomerActionStatus = null,

    /// Includes all encryption-related information.
    encryption_info: ?EncryptionInfo = null,

    /// Specifies the level of monitoring for the MSK cluster. The possible values
    /// are DEFAULT, PER_BROKER, PER_TOPIC_PER_BROKER, and PER_TOPIC_PER_PARTITION.
    enhanced_monitoring: ?EnhancedMonitoring = null,

    /// Log delivery information for the cluster.
    logging_info: ?LoggingInfo = null,

    /// The number of broker nodes in the cluster.
    number_of_broker_nodes: i32,

    /// The settings for open monitoring.
    open_monitoring: ?OpenMonitoringInfo = null,

    /// Specifies whether or not intelligent rebalancing is turned on for a newly
    /// created MSK Provisioned cluster with Express brokers. Intelligent
    /// rebalancing performs automatic partition balancing operations when you scale
    /// your clusters up or down. By default, intelligent rebalancing is ACTIVE for
    /// all new Express-based clusters.
    rebalancing: ?Rebalancing = null,

    /// This controls storage mode for supported storage tiers.
    storage_mode: ?StorageMode = null,

    /// The connection string to use to connect to the Apache ZooKeeper cluster.
    zookeeper_connect_string: ?[]const u8 = null,

    /// The connection string to use to connect to the Apache ZooKeeper cluster on a
    /// TLS port.
    zookeeper_connect_string_tls: ?[]const u8 = null,

    pub const json_field_names = .{
        .broker_node_group_info = "BrokerNodeGroupInfo",
        .client_authentication = "ClientAuthentication",
        .current_broker_software_info = "CurrentBrokerSoftwareInfo",
        .customer_action_status = "CustomerActionStatus",
        .encryption_info = "EncryptionInfo",
        .enhanced_monitoring = "EnhancedMonitoring",
        .logging_info = "LoggingInfo",
        .number_of_broker_nodes = "NumberOfBrokerNodes",
        .open_monitoring = "OpenMonitoring",
        .rebalancing = "Rebalancing",
        .storage_mode = "StorageMode",
        .zookeeper_connect_string = "ZookeeperConnectString",
        .zookeeper_connect_string_tls = "ZookeeperConnectStringTls",
    };
};
