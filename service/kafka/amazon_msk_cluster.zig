/// Details of an Amazon MSK Cluster.
pub const AmazonMskCluster = struct {
    /// The Amazon Resource Name (ARN) of an Amazon MSK cluster.
    msk_cluster_arn: []const u8,

    pub const json_field_names = .{
        .msk_cluster_arn = "MskClusterArn",
    };
};
