/// Provides details about the license configuration for an Amazon EC2 instance.
pub const AwsEc2LaunchTemplateDataLicenseSetDetails = struct {
    /// The Amazon Resource Name (ARN) of the license configuration.
    license_configuration_arn: ?[]const u8,

    pub const json_field_names = .{
        .license_configuration_arn = "LicenseConfigurationArn",
    };
};
