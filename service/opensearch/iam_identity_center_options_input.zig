/// Configuration settings for enabling and managing IAM Identity Center.
pub const IamIdentityCenterOptionsInput = struct {
    /// Specifies whether IAM Identity Center is enabled or disabled.
    enabled: ?bool = null,

    iam_identity_center_instance_arn: ?[]const u8 = null,

    /// The ARN of the IAM role associated with the IAM Identity Center application.
    iam_role_for_identity_center_application_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .enabled = "enabled",
        .iam_identity_center_instance_arn = "iamIdentityCenterInstanceArn",
        .iam_role_for_identity_center_application_arn = "iamRoleForIdentityCenterApplicationArn",
    };
};
