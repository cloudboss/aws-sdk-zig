/// A version of an IAM policy.
pub const AwsIamPolicyVersion = struct {
    /// Indicates when the version was created.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub CSPM, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    create_date: ?[]const u8 = null,

    /// Whether the version is the default version.
    is_default_version: ?bool = null,

    /// The identifier of the policy version.
    version_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .create_date = "CreateDate",
        .is_default_version = "IsDefaultVersion",
        .version_id = "VersionId",
    };
};
