const PolicyType = @import("policy_type.zig").PolicyType;
const PolicyStatus = @import("policy_status.zig").PolicyStatus;

/// Contains details for the version of a policy. Policies define what
/// operations a team that define the permissions for team resources.
pub const PolicyVersion = struct {
    /// Amazon Resource Name (ARN) for the team.
    arn: []const u8,

    /// Timestamp when the policy was created.
    creation_time: i64,

    /// Document that contains the policy contents.
    document: []const u8,

    /// Determines if the specified policy is the default for the team.
    is_default: bool,

    /// Timestamp when the policy was last updated.
    last_updated_time: i64,

    /// Name of the policy.
    name: []const u8,

    /// Amazon Resource Name (ARN) for the policy.
    policy_arn: []const u8,

    /// The type of policy.
    policy_type: PolicyType,

    /// Status for the policy. For example, if the policy is
    /// [attachable](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_groups_manage_attach-policy.html) or [deprecated](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_managed-deprecated.html).
    status: PolicyStatus,

    /// Verison ID
    version_id: i32,

    pub const json_field_names = .{
        .arn = "Arn",
        .creation_time = "CreationTime",
        .document = "Document",
        .is_default = "IsDefault",
        .last_updated_time = "LastUpdatedTime",
        .name = "Name",
        .policy_arn = "PolicyArn",
        .policy_type = "PolicyType",
        .status = "Status",
        .version_id = "VersionId",
    };
};
