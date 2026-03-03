/// An IAM role that the cluster can use to access other Amazon Web Services
/// services.
pub const AwsRedshiftClusterIamRole = struct {
    /// The status of the IAM role's association with the cluster.
    ///
    /// Valid values: `in-sync` | `adding` | `removing`
    apply_status: ?[]const u8 = null,

    /// The ARN of the IAM role.
    iam_role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .apply_status = "ApplyStatus",
        .iam_role_arn = "IamRoleArn",
    };
};
