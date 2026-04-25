/// Information about a role associated with an instance profile.
pub const AwsIamInstanceProfileRole = struct {
    /// The ARN of the role.
    arn: ?[]const u8 = null,

    /// The policy that grants an entity permission to assume the role.
    assume_role_policy_document: ?[]const u8 = null,

    /// Indicates when the role was created.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub CSPM, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    create_date: ?[]const u8 = null,

    /// The path to the role.
    path: ?[]const u8 = null,

    /// The identifier of the role.
    role_id: ?[]const u8 = null,

    /// The name of the role.
    role_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .assume_role_policy_document = "AssumeRolePolicyDocument",
        .create_date = "CreateDate",
        .path = "Path",
        .role_id = "RoleId",
        .role_name = "RoleName",
    };
};
