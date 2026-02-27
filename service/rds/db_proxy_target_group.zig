const ConnectionPoolConfigurationInfo = @import("connection_pool_configuration_info.zig").ConnectionPoolConfigurationInfo;

/// Represents a set of RDS DB instances, Aurora DB clusters, or both that a
/// proxy can connect to. Currently, each target group is associated with
/// exactly one RDS DB instance or Aurora DB cluster.
///
/// This data type is used as a response element in the
/// `DescribeDBProxyTargetGroups` action.
pub const DBProxyTargetGroup = struct {
    /// The settings that determine the size and behavior of the connection pool for
    /// the target group.
    connection_pool_config: ?ConnectionPoolConfigurationInfo,

    /// The date and time when the target group was first created.
    created_date: ?i64,

    /// The identifier for the RDS proxy associated with this target group.
    db_proxy_name: ?[]const u8,

    /// Indicates whether this target group is the first one used for connection
    /// requests by the associated proxy. Because each proxy is currently associated
    /// with a single target group, currently this setting is always `true`.
    is_default: ?bool,

    /// The current status of this target group. A status of `available` means the
    /// target group is correctly associated with a database. Other values indicate
    /// that you must wait for the target group to be ready, or take some action to
    /// resolve an issue.
    status: ?[]const u8,

    /// The Amazon Resource Name (ARN) representing the target group.
    target_group_arn: ?[]const u8,

    /// The identifier for the target group. This name must be unique for all target
    /// groups owned by your Amazon Web Services account in the specified Amazon Web
    /// Services Region.
    target_group_name: ?[]const u8,

    /// The date and time when the target group was last updated.
    updated_date: ?i64,
};
