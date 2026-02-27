const AwsMskClusterClusterInfoClientAuthenticationDetails = @import("aws_msk_cluster_cluster_info_client_authentication_details.zig").AwsMskClusterClusterInfoClientAuthenticationDetails;
const AwsMskClusterClusterInfoEncryptionInfoDetails = @import("aws_msk_cluster_cluster_info_encryption_info_details.zig").AwsMskClusterClusterInfoEncryptionInfoDetails;

/// Provide details about an Amazon Managed Streaming for Apache Kafka (Amazon
/// MSK) cluster.
pub const AwsMskClusterClusterInfoDetails = struct {
    /// Provides information for different modes of client authentication.
    client_authentication: ?AwsMskClusterClusterInfoClientAuthenticationDetails,

    /// The name of the cluster.
    cluster_name: ?[]const u8,

    /// The current version of the cluster.
    current_version: ?[]const u8,

    /// Includes encryption-related information, such as the KMS key used for
    /// encrypting data at rest and
    /// whether you want Amazon MSK to encrypt your data in transit.
    encryption_info: ?AwsMskClusterClusterInfoEncryptionInfoDetails,

    /// Specifies the level of monitoring for the cluster.
    enhanced_monitoring: ?[]const u8,

    /// The number of broker nodes in the cluster.
    number_of_broker_nodes: ?i32,

    pub const json_field_names = .{
        .client_authentication = "ClientAuthentication",
        .cluster_name = "ClusterName",
        .current_version = "CurrentVersion",
        .encryption_info = "EncryptionInfo",
        .enhanced_monitoring = "EnhancedMonitoring",
        .number_of_broker_nodes = "NumberOfBrokerNodes",
    };
};
