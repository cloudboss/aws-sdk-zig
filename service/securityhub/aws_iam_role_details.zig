const AwsIamAttachedManagedPolicy = @import("aws_iam_attached_managed_policy.zig").AwsIamAttachedManagedPolicy;
const AwsIamInstanceProfile = @import("aws_iam_instance_profile.zig").AwsIamInstanceProfile;
const AwsIamPermissionsBoundary = @import("aws_iam_permissions_boundary.zig").AwsIamPermissionsBoundary;
const AwsIamRolePolicy = @import("aws_iam_role_policy.zig").AwsIamRolePolicy;

/// Contains information about an IAM role, including all of the role's
/// policies.
pub const AwsIamRoleDetails = struct {
    /// The trust policy that grants permission to assume the role.
    assume_role_policy_document: ?[]const u8 = null,

    /// The list of the managed policies that are attached to the role.
    attached_managed_policies: ?[]const AwsIamAttachedManagedPolicy = null,

    /// Indicates when the role was created.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub CSPM, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    create_date: ?[]const u8 = null,

    /// The list of instance profiles that contain this role.
    instance_profile_list: ?[]const AwsIamInstanceProfile = null,

    /// The maximum session duration (in seconds) that you want to set for the
    /// specified role.
    max_session_duration: ?i32 = null,

    /// The path to the role.
    path: ?[]const u8 = null,

    permissions_boundary: ?AwsIamPermissionsBoundary = null,

    /// The stable and unique string identifying the role.
    role_id: ?[]const u8 = null,

    /// The friendly name that identifies the role.
    role_name: ?[]const u8 = null,

    /// The list of inline policies that are embedded in the role.
    role_policy_list: ?[]const AwsIamRolePolicy = null,

    pub const json_field_names = .{
        .assume_role_policy_document = "AssumeRolePolicyDocument",
        .attached_managed_policies = "AttachedManagedPolicies",
        .create_date = "CreateDate",
        .instance_profile_list = "InstanceProfileList",
        .max_session_duration = "MaxSessionDuration",
        .path = "Path",
        .permissions_boundary = "PermissionsBoundary",
        .role_id = "RoleId",
        .role_name = "RoleName",
        .role_policy_list = "RolePolicyList",
    };
};
