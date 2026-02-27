const IamIdentityCenterGroupAttribute = @import("iam_identity_center_group_attribute.zig").IamIdentityCenterGroupAttribute;
const IamIdentityCenterUserAttribute = @import("iam_identity_center_user_attribute.zig").IamIdentityCenterUserAttribute;

/// Describes IAM Identity Center options for creating an OpenSearch Serverless
/// security configuration in the form of a key-value map.
pub const CreateIamIdentityCenterConfigOptions = struct {
    /// The group attribute for this IAM Identity Center integration. Defaults to
    /// `GroupId`.
    group_attribute: ?IamIdentityCenterGroupAttribute,

    /// The ARN of the IAM Identity Center instance used to integrate with
    /// OpenSearch Serverless.
    instance_arn: []const u8,

    /// The user attribute for this IAM Identity Center integration. Defaults to
    /// `UserId`.
    user_attribute: ?IamIdentityCenterUserAttribute,

    pub const json_field_names = .{
        .group_attribute = "groupAttribute",
        .instance_arn = "instanceArn",
        .user_attribute = "userAttribute",
    };
};
