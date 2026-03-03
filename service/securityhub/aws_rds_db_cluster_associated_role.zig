/// An IAM role that is associated with the Amazon RDS DB cluster.
pub const AwsRdsDbClusterAssociatedRole = struct {
    /// The ARN of the IAM role.
    role_arn: ?[]const u8 = null,

    /// The status of the association between the IAM role and the DB cluster. Valid
    /// values are as follows:
    ///
    /// * `ACTIVE`
    ///
    /// * `INVALID`
    ///
    /// * `PENDING`
    status: ?[]const u8 = null,

    pub const json_field_names = .{
        .role_arn = "RoleArn",
        .status = "Status",
    };
};
