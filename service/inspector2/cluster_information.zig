const ClusterDetails = @import("cluster_details.zig").ClusterDetails;

/// Information about the cluster.
pub const ClusterInformation = struct {
    /// The cluster ARN.
    cluster_arn: []const u8,

    /// Details about the cluster.
    cluster_details: ?[]const ClusterDetails = null,

    pub const json_field_names = .{
        .cluster_arn = "clusterArn",
        .cluster_details = "clusterDetails",
    };
};
