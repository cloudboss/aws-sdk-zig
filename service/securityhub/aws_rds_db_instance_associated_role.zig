/// An IAM role associated with the DB instance.
pub const AwsRdsDbInstanceAssociatedRole = struct {
    /// The name of the feature associated with the IAM role.
    feature_name: ?[]const u8 = null,

    /// The ARN of the IAM role that is associated with the DB
    /// instance.
    role_arn: ?[]const u8 = null,

    /// Describes the state of the association between the IAM role and the DB
    /// instance. The
    /// `Status` property returns one of the following values:
    ///
    /// * `ACTIVE` - The IAM role ARN is associated with the DB instance and can
    /// be used to access other Amazon Web Services services on your behalf.
    ///
    /// * `PENDING` - The IAM role ARN is being associated with the DB
    /// instance.
    ///
    /// * `INVALID` - The IAM role ARN is associated with the DB instance. But
    /// the DB instance is unable to assume the IAM role in order to access other
    /// Amazon Web Services
    /// services on your behalf.
    status: ?[]const u8 = null,

    pub const json_field_names = .{
        .feature_name = "FeatureName",
        .role_arn = "RoleArn",
        .status = "Status",
    };
};
