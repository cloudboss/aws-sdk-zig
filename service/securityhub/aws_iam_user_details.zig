const AwsIamAttachedManagedPolicy = @import("aws_iam_attached_managed_policy.zig").AwsIamAttachedManagedPolicy;
const AwsIamPermissionsBoundary = @import("aws_iam_permissions_boundary.zig").AwsIamPermissionsBoundary;
const AwsIamUserPolicy = @import("aws_iam_user_policy.zig").AwsIamUserPolicy;

/// Information about an IAM user.
pub const AwsIamUserDetails = struct {
    /// A list of the managed policies that are attached to the user.
    attached_managed_policies: ?[]const AwsIamAttachedManagedPolicy = null,

    /// Indicates when the user was created.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub CSPM, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    create_date: ?[]const u8 = null,

    /// A list of IAM groups that the user belongs to.
    group_list: ?[]const []const u8 = null,

    /// The path to the user.
    path: ?[]const u8 = null,

    /// The permissions boundary for the user.
    permissions_boundary: ?AwsIamPermissionsBoundary = null,

    /// The unique identifier for the user.
    user_id: ?[]const u8 = null,

    /// The name of the user.
    user_name: ?[]const u8 = null,

    /// The list of inline policies that are embedded in the user.
    user_policy_list: ?[]const AwsIamUserPolicy = null,

    pub const json_field_names = .{
        .attached_managed_policies = "AttachedManagedPolicies",
        .create_date = "CreateDate",
        .group_list = "GroupList",
        .path = "Path",
        .permissions_boundary = "PermissionsBoundary",
        .user_id = "UserId",
        .user_name = "UserName",
        .user_policy_list = "UserPolicyList",
    };
};
