const SetParameterValueConfiguration = @import("set_parameter_value_configuration.zig").SetParameterValueConfiguration;

/// The set parameter operation that sets parameters in custom action.
pub const CustomActionSetParametersOperation = struct {
    /// The parameter that determines the value configuration.
    parameter_value_configurations: []const SetParameterValueConfiguration,

    pub const json_field_names = .{
        .parameter_value_configurations = "ParameterValueConfigurations",
    };
};
