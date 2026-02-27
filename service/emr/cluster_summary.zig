const ClusterStatus = @import("cluster_status.zig").ClusterStatus;

/// The summary description of the cluster.
pub const ClusterSummary = struct {
    /// The Amazon Resource Name of the cluster.
    cluster_arn: ?[]const u8,

    /// The unique identifier for the cluster.
    id: ?[]const u8,

    /// The name of the cluster.
    name: ?[]const u8,

    /// An approximation of the cost of the cluster, represented in m1.small/hours.
    /// This value
    /// is incremented one time for every hour an m1.small instance runs. Larger
    /// instances are
    /// weighted more, so an Amazon EC2 instance that is roughly four times more
    /// expensive
    /// would result in the normalized instance hours being incremented by four.
    /// This result is
    /// only an approximation and does not reflect the actual billing rate.
    normalized_instance_hours: ?i32,

    /// The Amazon Resource Name (ARN) of the Outpost where the cluster is launched.
    outpost_arn: ?[]const u8,

    /// The details about the current status of the cluster.
    status: ?ClusterStatus,

    pub const json_field_names = .{
        .cluster_arn = "ClusterArn",
        .id = "Id",
        .name = "Name",
        .normalized_instance_hours = "NormalizedInstanceHours",
        .outpost_arn = "OutpostArn",
        .status = "Status",
    };
};
