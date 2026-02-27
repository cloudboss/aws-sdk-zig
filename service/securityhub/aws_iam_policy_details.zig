const AwsIamPolicyVersion = @import("aws_iam_policy_version.zig").AwsIamPolicyVersion;

/// Represents an IAM permissions policy.
pub const AwsIamPolicyDetails = struct {
    /// The number of users, groups, and roles that the policy is attached to.
    attachment_count: ?i32,

    /// When the policy was created.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    create_date: ?[]const u8,

    /// The identifier of the default version of the policy.
    default_version_id: ?[]const u8,

    /// A description of the policy.
    description: ?[]const u8,

    /// Whether the policy can be attached to a user, group, or role.
    is_attachable: ?bool,

    /// The path to the policy.
    path: ?[]const u8,

    /// The number of users and roles that use the policy to set the permissions
    /// boundary.
    permissions_boundary_usage_count: ?i32,

    /// The unique identifier of the policy.
    policy_id: ?[]const u8,

    /// The name of the policy.
    policy_name: ?[]const u8,

    /// List of versions of the policy.
    policy_version_list: ?[]const AwsIamPolicyVersion,

    /// When the policy was most recently updated.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    update_date: ?[]const u8,

    pub const json_field_names = .{
        .attachment_count = "AttachmentCount",
        .create_date = "CreateDate",
        .default_version_id = "DefaultVersionId",
        .description = "Description",
        .is_attachable = "IsAttachable",
        .path = "Path",
        .permissions_boundary_usage_count = "PermissionsBoundaryUsageCount",
        .policy_id = "PolicyId",
        .policy_name = "PolicyName",
        .policy_version_list = "PolicyVersionList",
        .update_date = "UpdateDate",
    };
};
