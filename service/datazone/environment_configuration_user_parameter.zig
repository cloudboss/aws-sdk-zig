const EnvironmentParameter = @import("environment_parameter.zig").EnvironmentParameter;
const EnvironmentResolvedAccount = @import("environment_resolved_account.zig").EnvironmentResolvedAccount;

/// The environment configuration user parameters.
pub const EnvironmentConfigurationUserParameter = struct {
    /// The environment configuration name.
    environment_configuration_name: ?[]const u8 = null,

    /// The ID of the environment.
    environment_id: ?[]const u8 = null,

    /// The environment parameters.
    environment_parameters: ?[]const EnvironmentParameter = null,

    /// Specifies the account/Region that is to be used during project creation for
    /// a particular blueprint.
    environment_resolved_account: ?EnvironmentResolvedAccount = null,

    pub const json_field_names = .{
        .environment_configuration_name = "environmentConfigurationName",
        .environment_id = "environmentId",
        .environment_parameters = "environmentParameters",
        .environment_resolved_account = "environmentResolvedAccount",
    };
};
