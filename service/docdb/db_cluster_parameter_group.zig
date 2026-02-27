/// Detailed information about a cluster parameter group.
pub const DBClusterParameterGroup = struct {
    /// The Amazon Resource Name (ARN) for the cluster parameter group.
    db_cluster_parameter_group_arn: ?[]const u8,

    /// Provides the name of the cluster parameter group.
    db_cluster_parameter_group_name: ?[]const u8,

    /// Provides the name of the parameter group family that this cluster parameter
    /// group is compatible with.
    db_parameter_group_family: ?[]const u8,

    /// Provides the customer-specified description for this cluster parameter
    /// group.
    description: ?[]const u8,
};
