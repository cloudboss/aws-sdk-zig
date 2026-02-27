/// Contains the details of an Amazon Neptune DB cluster parameter group.
///
/// This data type is used as a response element in the
/// DescribeDBClusterParameterGroups action.
pub const DBClusterParameterGroup = struct {
    /// The Amazon Resource Name (ARN) for the DB cluster parameter group.
    db_cluster_parameter_group_arn: ?[]const u8,

    /// Provides the name of the DB cluster parameter group.
    db_cluster_parameter_group_name: ?[]const u8,

    /// Provides the name of the DB parameter group family that this DB cluster
    /// parameter group is
    /// compatible with.
    db_parameter_group_family: ?[]const u8,

    /// Provides the customer-specified description for this DB cluster parameter
    /// group.
    description: ?[]const u8,
};
