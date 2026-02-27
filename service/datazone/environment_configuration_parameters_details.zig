const EnvironmentConfigurationParameter = @import("environment_configuration_parameter.zig").EnvironmentConfigurationParameter;

/// The details of the environment configuration parameter.
pub const EnvironmentConfigurationParametersDetails = struct {
    /// The parameter overrides.
    parameter_overrides: ?[]const EnvironmentConfigurationParameter,

    /// The resolved environment configuration parameters.
    resolved_parameters: ?[]const EnvironmentConfigurationParameter,

    /// Ssm path environment configuration parameters.
    ssm_path: ?[]const u8,

    pub const json_field_names = .{
        .parameter_overrides = "parameterOverrides",
        .resolved_parameters = "resolvedParameters",
        .ssm_path = "ssmPath",
    };
};
