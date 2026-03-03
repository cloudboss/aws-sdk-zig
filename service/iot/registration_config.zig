/// The registration configuration.
pub const RegistrationConfig = struct {
    /// The ARN of the role.
    role_arn: ?[]const u8 = null,

    /// The template body.
    template_body: ?[]const u8 = null,

    /// The name of the provisioning template.
    template_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .role_arn = "roleArn",
        .template_body = "templateBody",
        .template_name = "templateName",
    };
};
