/// Configuration settings for IAM Identity Center in an OpenSearch application.
pub const IamIdentityCenterOptions = struct {
    /// Indicates whether IAM Identity Center is enabled for the OpenSearch
    /// application.
    enabled: ?bool,

    iam_identity_center_application_arn: ?[]const u8,

    iam_identity_center_instance_arn: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the IAM role assigned to the IAM Identity
    /// Center
    /// application for the OpenSearch application.
    iam_role_for_identity_center_application_arn: ?[]const u8,

    pub const json_field_names = .{
        .enabled = "enabled",
        .iam_identity_center_application_arn = "iamIdentityCenterApplicationArn",
        .iam_identity_center_instance_arn = "iamIdentityCenterInstanceArn",
        .iam_role_for_identity_center_application_arn = "iamRoleForIdentityCenterApplicationArn",
    };
};
