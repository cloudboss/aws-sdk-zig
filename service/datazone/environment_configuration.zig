const AwsAccount = @import("aws_account.zig").AwsAccount;
const Region = @import("region.zig").Region;
const EnvironmentConfigurationParametersDetails = @import("environment_configuration_parameters_details.zig").EnvironmentConfigurationParametersDetails;
const DeploymentMode = @import("deployment_mode.zig").DeploymentMode;

/// The configuration of an environment.
pub const EnvironmentConfiguration = struct {
    /// The account pools used by a custom project profile.
    account_pools: ?[]const []const u8 = null,

    /// The Amazon Web Services account of the environment.
    aws_account: ?AwsAccount = null,

    /// The Amazon Web Services Region of the environment.
    aws_region: ?Region = null,

    /// The configuration parameters of the environment.
    configuration_parameters: ?EnvironmentConfigurationParametersDetails = null,

    /// The deployment mode of the environment.
    deployment_mode: ?DeploymentMode = null,

    /// The deployment order of the environment.
    deployment_order: ?i32 = null,

    /// The environment description.
    description: ?[]const u8 = null,

    /// The environment blueprint ID.
    environment_blueprint_id: []const u8,

    /// The environment ID.
    id: ?[]const u8 = null,

    /// The environment name.
    name: []const u8,

    pub const json_field_names = .{
        .account_pools = "accountPools",
        .aws_account = "awsAccount",
        .aws_region = "awsRegion",
        .configuration_parameters = "configurationParameters",
        .deployment_mode = "deploymentMode",
        .deployment_order = "deploymentOrder",
        .description = "description",
        .environment_blueprint_id = "environmentBlueprintId",
        .id = "id",
        .name = "name",
    };
};
