const AwsIamAttachedManagedPolicy = @import("aws_iam_attached_managed_policy.zig").AwsIamAttachedManagedPolicy;
const AwsIamGroupPolicy = @import("aws_iam_group_policy.zig").AwsIamGroupPolicy;

/// Contains details about an IAM group.
pub const AwsIamGroupDetails = struct {
    /// A list of the managed policies that are attached to the IAM group.
    attached_managed_policies: ?[]const AwsIamAttachedManagedPolicy = null,

    /// Indicates when the IAM group was created.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    create_date: ?[]const u8 = null,

    /// The identifier of the IAM group.
    group_id: ?[]const u8 = null,

    /// The name of the IAM group.
    group_name: ?[]const u8 = null,

    /// The list of inline policies that are embedded in the group.
    group_policy_list: ?[]const AwsIamGroupPolicy = null,

    /// The path to the group.
    path: ?[]const u8 = null,

    pub const json_field_names = .{
        .attached_managed_policies = "AttachedManagedPolicies",
        .create_date = "CreateDate",
        .group_id = "GroupId",
        .group_name = "GroupName",
        .group_policy_list = "GroupPolicyList",
        .path = "Path",
    };
};
