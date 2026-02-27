const Status = @import("status.zig").Status;

/// A list of Amazon DocumentDB elastic clusters.
pub const ClusterInList = struct {
    /// The ARN identifier of the elastic cluster.
    cluster_arn: []const u8,

    /// The name of the elastic cluster.
    cluster_name: []const u8,

    /// The status of the elastic cluster.
    status: Status,

    pub const json_field_names = .{
        .cluster_arn = "clusterArn",
        .cluster_name = "clusterName",
        .status = "status",
    };
};
