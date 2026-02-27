/// Represents a Regional cluster
pub const RegionalCluster = struct {
    /// The Amazon Resource Name (ARN) the Regional cluster
    arn: ?[]const u8,

    /// The name of the Regional cluster
    cluster_name: ?[]const u8,

    /// The Region the current Regional cluster is assigned to.
    region: ?[]const u8,

    /// The status of the Regional cluster.
    status: ?[]const u8,

    pub const json_field_names = .{
        .arn = "ARN",
        .cluster_name = "ClusterName",
        .region = "Region",
        .status = "Status",
    };
};
