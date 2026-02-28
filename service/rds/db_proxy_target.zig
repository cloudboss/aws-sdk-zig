const TargetRole = @import("target_role.zig").TargetRole;
const TargetHealth = @import("target_health.zig").TargetHealth;
const TargetType = @import("target_type.zig").TargetType;

/// Contains the details for an RDS Proxy target. It represents an RDS DB
/// instance or Aurora DB cluster that the proxy can connect to. One or more
/// targets are associated with an RDS Proxy target group.
///
/// This data type is used as a response element in the `DescribeDBProxyTargets`
/// action.
pub const DBProxyTarget = struct {
    /// The writer endpoint for the RDS DB instance or Aurora DB cluster.
    endpoint: ?[]const u8,

    /// The port that the RDS Proxy uses to connect to the target RDS DB instance or
    /// Aurora DB cluster.
    port: ?i32,

    /// The identifier representing the target. It can be the instance identifier
    /// for an RDS DB instance, or the cluster identifier for an Aurora DB cluster.
    rds_resource_id: ?[]const u8,

    /// A value that indicates whether the target of the proxy can be used for
    /// read/write or read-only operations.
    role: ?TargetRole,

    /// The Amazon Resource Name (ARN) for the RDS DB instance or Aurora DB cluster.
    target_arn: ?[]const u8,

    /// Information about the connection health of the RDS Proxy target.
    target_health: ?TargetHealth,

    /// The DB cluster identifier when the target represents an Aurora DB cluster.
    /// This field is blank when the target represents an RDS DB instance.
    tracked_cluster_id: ?[]const u8,

    /// Specifies the kind of database, such as an RDS DB instance or an Aurora DB
    /// cluster, that the target represents.
    @"type": ?TargetType,
};
