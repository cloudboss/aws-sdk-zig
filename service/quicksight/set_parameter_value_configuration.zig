const DestinationParameterValueConfiguration = @import("destination_parameter_value_configuration.zig").DestinationParameterValueConfiguration;

/// The configuration of adding parameters in action.
pub const SetParameterValueConfiguration = struct {
    /// The destination parameter name of the `SetParameterValueConfiguration`.
    destination_parameter_name: []const u8,

    value: DestinationParameterValueConfiguration,

    pub const json_field_names = .{
        .destination_parameter_name = "DestinationParameterName",
        .value = "Value",
    };
};
