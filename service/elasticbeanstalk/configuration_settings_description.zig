const ConfigurationDeploymentStatus = @import("configuration_deployment_status.zig").ConfigurationDeploymentStatus;
const ConfigurationOptionSetting = @import("configuration_option_setting.zig").ConfigurationOptionSetting;

/// Describes the settings for a configuration set.
pub const ConfigurationSettingsDescription = struct {
    /// The name of the application associated with this configuration set.
    application_name: ?[]const u8 = null,

    /// The date (in UTC time) when this configuration set was created.
    date_created: ?i64 = null,

    /// The date (in UTC time) when this configuration set was last modified.
    date_updated: ?i64 = null,

    /// If this configuration set is associated with an environment, the
    /// `DeploymentStatus` parameter indicates the deployment status of this
    /// configuration set:
    ///
    /// * `null`: This configuration is not associated with a running
    /// environment.
    ///
    /// * `pending`: This is a draft configuration that is not deployed to the
    ///   associated
    /// environment but is in the process of deploying.
    ///
    /// * `deployed`: This is the configuration that is currently deployed to the
    /// associated running environment.
    ///
    /// * `failed`: This is a draft configuration that failed to successfully
    /// deploy.
    deployment_status: ?ConfigurationDeploymentStatus = null,

    /// Describes this configuration set.
    description: ?[]const u8 = null,

    /// If not `null`, the name of the environment for this configuration set.
    environment_name: ?[]const u8 = null,

    /// A list of the configuration options and their values in this configuration
    /// set.
    option_settings: ?[]const ConfigurationOptionSetting = null,

    /// The ARN of the platform version.
    platform_arn: ?[]const u8 = null,

    /// The name of the solution stack this configuration set uses.
    solution_stack_name: ?[]const u8 = null,

    /// If not `null`, the name of the configuration template for this
    /// configuration set.
    template_name: ?[]const u8 = null,
};
