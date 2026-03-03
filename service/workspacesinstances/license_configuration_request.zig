/// Specifies license configuration for WorkSpace Instance.
pub const LicenseConfigurationRequest = struct {
    /// ARN of the license configuration for the WorkSpace Instance.
    license_configuration_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .license_configuration_arn = "LicenseConfigurationArn",
    };
};
