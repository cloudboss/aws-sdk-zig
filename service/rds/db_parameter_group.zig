/// Contains the details of an Amazon RDS DB parameter group.
///
/// This data type is used as a response element in the
/// `DescribeDBParameterGroups` action.
pub const DBParameterGroup = struct {
    /// The Amazon Resource Name (ARN) for the DB parameter group.
    db_parameter_group_arn: ?[]const u8,

    /// The name of the DB parameter group family that this DB parameter group is
    /// compatible with.
    db_parameter_group_family: ?[]const u8,

    /// The name of the DB parameter group.
    db_parameter_group_name: ?[]const u8,

    /// Provides the customer-specified description for this DB parameter group.
    description: ?[]const u8,
};
