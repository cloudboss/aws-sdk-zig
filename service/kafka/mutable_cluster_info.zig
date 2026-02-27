const BrokerCountUpdateInfo = @import("broker_count_update_info.zig").BrokerCountUpdateInfo;
const BrokerEBSVolumeInfo = @import("broker_ebs_volume_info.zig").BrokerEBSVolumeInfo;
const ClientAuthentication = @import("client_authentication.zig").ClientAuthentication;
const ConfigurationInfo = @import("configuration_info.zig").ConfigurationInfo;
const ConnectivityInfo = @import("connectivity_info.zig").ConnectivityInfo;
const EncryptionInfo = @import("encryption_info.zig").EncryptionInfo;
const EnhancedMonitoring = @import("enhanced_monitoring.zig").EnhancedMonitoring;
const LoggingInfo = @import("logging_info.zig").LoggingInfo;
const OpenMonitoring = @import("open_monitoring.zig").OpenMonitoring;
const Rebalancing = @import("rebalancing.zig").Rebalancing;
const StorageMode = @import("storage_mode.zig").StorageMode;

/// Information about cluster attributes that can be updated via update APIs.
pub const MutableClusterInfo = struct {
    /// Describes brokers being changed during a broker count update.
    broker_count_update_info: ?BrokerCountUpdateInfo,

    /// Specifies the size of the EBS volume and the ID of the associated broker.
    broker_ebs_volume_info: ?[]const BrokerEBSVolumeInfo,

    /// Includes all client authentication information.
    client_authentication: ?ClientAuthentication,

    /// Information about the changes in the configuration of the brokers.
    configuration_info: ?ConfigurationInfo,

    /// Information about the broker access configuration.
    connectivity_info: ?ConnectivityInfo,

    /// Includes all encryption-related information.
    encryption_info: ?EncryptionInfo,

    /// Specifies which Apache Kafka metrics Amazon MSK gathers and sends to Amazon
    /// CloudWatch for this cluster.
    enhanced_monitoring: ?EnhancedMonitoring,

    /// Information about the Amazon MSK broker type.
    instance_type: ?[]const u8,

    /// The Apache Kafka version.
    kafka_version: ?[]const u8,

    /// You can configure your MSK cluster to send broker logs to different
    /// destination types. This is a container for the configuration details related
    /// to broker logs.
    logging_info: ?LoggingInfo,

    /// The number of broker nodes in the cluster.
    number_of_broker_nodes: ?i32,

    /// The settings for open monitoring.
    open_monitoring: ?OpenMonitoring,

    /// Describes the intelligent rebalancing configuration of an MSK Provisioned
    /// cluster with Express brokers.
    rebalancing: ?Rebalancing,

    /// This controls storage mode for supported storage tiers.
    storage_mode: ?StorageMode,

    pub const json_field_names = .{
        .broker_count_update_info = "BrokerCountUpdateInfo",
        .broker_ebs_volume_info = "BrokerEBSVolumeInfo",
        .client_authentication = "ClientAuthentication",
        .configuration_info = "ConfigurationInfo",
        .connectivity_info = "ConnectivityInfo",
        .encryption_info = "EncryptionInfo",
        .enhanced_monitoring = "EnhancedMonitoring",
        .instance_type = "InstanceType",
        .kafka_version = "KafkaVersion",
        .logging_info = "LoggingInfo",
        .number_of_broker_nodes = "NumberOfBrokerNodes",
        .open_monitoring = "OpenMonitoring",
        .rebalancing = "Rebalancing",
        .storage_mode = "StorageMode",
    };
};
