const AwsMskClusterClusterInfoDetails = @import("aws_msk_cluster_cluster_info_details.zig").AwsMskClusterClusterInfoDetails;

/// Provides details about an Amazon Managed Streaming for Apache Kafka (Amazon
/// MSK) cluster.
pub const AwsMskClusterDetails = struct {
    /// Provides information about a cluster.
    cluster_info: ?AwsMskClusterClusterInfoDetails = null,

    pub const json_field_names = .{
        .cluster_info = "ClusterInfo",
    };
};
