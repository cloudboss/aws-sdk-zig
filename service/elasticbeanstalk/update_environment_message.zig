const ConfigurationOptionSetting = @import("configuration_option_setting.zig").ConfigurationOptionSetting;
const OptionSpecification = @import("option_specification.zig").OptionSpecification;
const EnvironmentTier = @import("environment_tier.zig").EnvironmentTier;

/// Request to update an environment.
pub const UpdateEnvironmentMessage = struct {
    /// The name of the application with which the environment is associated.
    application_name: ?[]const u8,

    /// If this parameter is specified, AWS Elastic Beanstalk updates the
    /// description of this
    /// environment.
    description: ?[]const u8,

    /// The ID of the environment to update.
    ///
    /// If no environment with this ID exists, AWS Elastic Beanstalk returns an
    /// `InvalidParameterValue` error.
    ///
    /// Condition: You must specify either this or an EnvironmentName, or both. If
    /// you do not
    /// specify either, AWS Elastic Beanstalk returns `MissingRequiredParameter`
    /// error.
    environment_id: ?[]const u8,

    /// The name of the environment to update. If no environment with this name
    /// exists, AWS
    /// Elastic Beanstalk returns an `InvalidParameterValue` error.
    ///
    /// Condition: You must specify either this or an EnvironmentId, or both. If you
    /// do not
    /// specify either, AWS Elastic Beanstalk returns `MissingRequiredParameter`
    /// error.
    environment_name: ?[]const u8,

    /// The name of the group to which the target environment belongs. Specify a
    /// group name
    /// only if the environment's name is specified in an environment manifest and
    /// not with the
    /// environment name or environment ID parameters. See [Environment Manifest
    /// (env.yaml)](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/environment-cfg-manifest.html) for details.
    group_name: ?[]const u8,

    /// If specified, AWS Elastic Beanstalk updates the configuration set associated
    /// with the
    /// running environment and sets the specified configuration options to the
    /// requested
    /// value.
    option_settings: ?[]const ConfigurationOptionSetting,

    /// A list of custom user-defined configuration options to remove from the
    /// configuration
    /// set for this environment.
    options_to_remove: ?[]const OptionSpecification,

    /// The ARN of the platform, if used.
    platform_arn: ?[]const u8,

    /// This specifies the platform version that the environment will run after the
    /// environment
    /// is updated.
    solution_stack_name: ?[]const u8,

    /// If this parameter is specified, AWS Elastic Beanstalk deploys this
    /// configuration
    /// template to the environment. If no such configuration template is found, AWS
    /// Elastic Beanstalk
    /// returns an `InvalidParameterValue` error.
    template_name: ?[]const u8,

    /// This specifies the tier to use to update the environment.
    ///
    /// Condition: At this time, if you change the tier version, name, or type, AWS
    /// Elastic
    /// Beanstalk returns `InvalidParameterValue` error.
    tier: ?EnvironmentTier,

    /// If this parameter is specified, AWS Elastic Beanstalk deploys the named
    /// application
    /// version to the environment. If no such application version is found, returns
    /// an
    /// `InvalidParameterValue` error.
    version_label: ?[]const u8,
};
