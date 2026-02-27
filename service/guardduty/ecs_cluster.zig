const EcsClusterStatus = @import("ecs_cluster_status.zig").EcsClusterStatus;

/// Contains information about the Amazon ECS cluster involved in a GuardDuty
/// finding,
/// including cluster identification and status.
pub const EcsCluster = struct {
    /// A list of unique identifiers for the Amazon EC2 instances that serve as
    /// container instances in
    /// the Amazon ECS cluster.
    ec_2_instance_uids: ?[]const []const u8,

    /// The current status of the Amazon ECS cluster.
    status: ?EcsClusterStatus,

    pub const json_field_names = .{
        .ec_2_instance_uids = "Ec2InstanceUids",
        .status = "Status",
    };
};
