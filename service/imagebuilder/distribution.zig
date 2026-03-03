const AmiDistributionConfiguration = @import("ami_distribution_configuration.zig").AmiDistributionConfiguration;
const ContainerDistributionConfiguration = @import("container_distribution_configuration.zig").ContainerDistributionConfiguration;
const FastLaunchConfiguration = @import("fast_launch_configuration.zig").FastLaunchConfiguration;
const LaunchTemplateConfiguration = @import("launch_template_configuration.zig").LaunchTemplateConfiguration;
const S3ExportConfiguration = @import("s3_export_configuration.zig").S3ExportConfiguration;
const SsmParameterConfiguration = @import("ssm_parameter_configuration.zig").SsmParameterConfiguration;

/// Defines the settings for a specific Region.
pub const Distribution = struct {
    /// The specific AMI settings; for example, launch permissions or AMI tags.
    ami_distribution_configuration: ?AmiDistributionConfiguration = null,

    /// Container distribution settings for encryption, licensing, and sharing in a
    /// specific
    /// Region.
    container_distribution_configuration: ?ContainerDistributionConfiguration = null,

    /// The Windows faster-launching configurations to use for AMI distribution.
    fast_launch_configurations: ?[]const FastLaunchConfiguration = null,

    /// A group of launchTemplateConfiguration settings that apply to image
    /// distribution for
    /// specified accounts.
    launch_template_configurations: ?[]const LaunchTemplateConfiguration = null,

    /// The License Manager Configuration to associate with the AMI in the specified
    /// Region.
    license_configuration_arns: ?[]const []const u8 = null,

    /// The target Region.
    region: []const u8,

    /// Configure export settings to deliver disk images created from your image
    /// build,
    /// using a file format that is compatible with your VMs in that Region.
    s_3_export_configuration: ?S3ExportConfiguration = null,

    /// Contains settings to update Amazon Web Services Systems Manager (SSM)
    /// Parameter Store Parameters with
    /// output AMI IDs from the build by target Region.
    ssm_parameter_configurations: ?[]const SsmParameterConfiguration = null,

    pub const json_field_names = .{
        .ami_distribution_configuration = "amiDistributionConfiguration",
        .container_distribution_configuration = "containerDistributionConfiguration",
        .fast_launch_configurations = "fastLaunchConfigurations",
        .launch_template_configurations = "launchTemplateConfigurations",
        .license_configuration_arns = "licenseConfigurationArns",
        .region = "region",
        .s_3_export_configuration = "s3ExportConfiguration",
        .ssm_parameter_configurations = "ssmParameterConfigurations",
    };
};
