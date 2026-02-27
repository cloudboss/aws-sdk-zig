const aws = @import("aws");

const BrokerNodeGroupInfo = @import("broker_node_group_info.zig").BrokerNodeGroupInfo;
const ClientAuthentication = @import("client_authentication.zig").ClientAuthentication;
const BrokerSoftwareInfo = @import("broker_software_info.zig").BrokerSoftwareInfo;
const CustomerActionStatus = @import("customer_action_status.zig").CustomerActionStatus;
const EncryptionInfo = @import("encryption_info.zig").EncryptionInfo;
const EnhancedMonitoring = @import("enhanced_monitoring.zig").EnhancedMonitoring;
const LoggingInfo = @import("logging_info.zig").LoggingInfo;
const OpenMonitoring = @import("open_monitoring.zig").OpenMonitoring;
const Rebalancing = @import("rebalancing.zig").Rebalancing;
const ClusterState = @import("cluster_state.zig").ClusterState;
const StateInfo = @import("state_info.zig").StateInfo;
const StorageMode = @import("storage_mode.zig").StorageMode;

/// Returns information about a cluster.
pub const ClusterInfo = struct {
    /// Arn of active cluster operation.
    active_operation_arn: ?[]const u8,

    /// Information about the broker nodes.
    broker_node_group_info: ?BrokerNodeGroupInfo,

    /// Includes all client authentication information.
    client_authentication: ?ClientAuthentication,

    /// The Amazon Resource Name (ARN) that uniquely identifies the cluster.
    cluster_arn: ?[]const u8,

    /// The name of the cluster.
    cluster_name: ?[]const u8,

    /// The time when the cluster was created.
    creation_time: ?i64,

    /// Information about the version of software currently deployed on the Apache
    /// Kafka brokers in the cluster.
    current_broker_software_info: ?BrokerSoftwareInfo,

    /// The current version of the MSK cluster.
    current_version: ?[]const u8,

    /// Determines if there is an action required from the customer.
    customer_action_status: ?CustomerActionStatus,

    /// Includes all encryption-related information.
    encryption_info: ?EncryptionInfo,

    /// Specifies which metrics are gathered for the MSK cluster. This property has
    /// the following possible values: DEFAULT, PER_BROKER, PER_TOPIC_PER_BROKER,
    /// and PER_TOPIC_PER_PARTITION. For a list of the metrics associated with each
    /// of these levels of monitoring, see
    /// [Monitoring](https://docs.aws.amazon.com/msk/latest/developerguide/monitoring.html).
    enhanced_monitoring: ?EnhancedMonitoring,

    logging_info: ?LoggingInfo,

    /// The number of broker nodes in the cluster.
    number_of_broker_nodes: ?i32,

    /// Settings for open monitoring using Prometheus.
    open_monitoring: ?OpenMonitoring,

    /// Contains information about intelligent rebalancing for new MSK Provisioned
    /// clusters with Express brokers. By default, intelligent rebalancing status is
    /// ACTIVE.
    rebalancing: ?Rebalancing,

    /// The state of the cluster. The possible states are ACTIVE, CREATING,
    /// DELETING, FAILED, HEALING, MAINTENANCE, REBOOTING_BROKER, and UPDATING.
    state: ?ClusterState,

    state_info: ?StateInfo,

    /// This controls storage mode for supported storage tiers.
    storage_mode: ?StorageMode,

    /// Tags attached to the cluster.
    tags: ?[]const aws.map.StringMapEntry,

    /// The connection string to use to connect to the Apache ZooKeeper cluster.
    zookeeper_connect_string: ?[]const u8,

    /// The connection string to use to connect to zookeeper cluster on Tls port.
    zookeeper_connect_string_tls: ?[]const u8,

    pub const json_field_names = .{
        .active_operation_arn = "ActiveOperationArn",
        .broker_node_group_info = "BrokerNodeGroupInfo",
        .client_authentication = "ClientAuthentication",
        .cluster_arn = "ClusterArn",
        .cluster_name = "ClusterName",
        .creation_time = "CreationTime",
        .current_broker_software_info = "CurrentBrokerSoftwareInfo",
        .current_version = "CurrentVersion",
        .customer_action_status = "CustomerActionStatus",
        .encryption_info = "EncryptionInfo",
        .enhanced_monitoring = "EnhancedMonitoring",
        .logging_info = "LoggingInfo",
        .number_of_broker_nodes = "NumberOfBrokerNodes",
        .open_monitoring = "OpenMonitoring",
        .rebalancing = "Rebalancing",
        .state = "State",
        .state_info = "StateInfo",
        .storage_mode = "StorageMode",
        .tags = "Tags",
        .zookeeper_connect_string = "ZookeeperConnectString",
        .zookeeper_connect_string_tls = "ZookeeperConnectStringTls",
    };
};
