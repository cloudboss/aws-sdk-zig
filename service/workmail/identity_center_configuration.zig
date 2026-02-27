/// The IAM Identity Center configuration.
pub const IdentityCenterConfiguration = struct {
    /// The Amazon Resource Name (ARN) of IAMIdentity Center Application for
    /// WorkMail. Must be created by the WorkMail API, see
    /// CreateIdentityCenterApplication.
    application_arn: []const u8,

    /// The Amazon Resource Name (ARN) of the of IAM Identity Center instance. Must
    /// be in the same AWS account and region as WorkMail organization.
    instance_arn: []const u8,

    pub const json_field_names = .{
        .application_arn = "ApplicationArn",
        .instance_arn = "InstanceArn",
    };
};
