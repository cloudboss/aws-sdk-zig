/// A license configuration to associate with the instances.
pub const LicenseSpecification = struct {
    /// The Amazon Resource Name (ARN) of the license configuration.
    license_configuration_arn: []const u8,

    pub const json_field_names = .{
        .license_configuration_arn = "licenseConfigurationArn",
    };
};
