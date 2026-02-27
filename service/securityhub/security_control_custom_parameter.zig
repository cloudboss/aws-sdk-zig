const aws = @import("aws");

const ParameterConfiguration = @import("parameter_configuration.zig").ParameterConfiguration;

/// A list of security controls and control parameter values that are included
/// in a configuration policy.
pub const SecurityControlCustomParameter = struct {
    /// An object that specifies parameter values for a control in a configuration
    /// policy.
    parameters: ?[]const aws.map.MapEntry(ParameterConfiguration),

    /// The ID of the security control.
    security_control_id: ?[]const u8,

    pub const json_field_names = .{
        .parameters = "Parameters",
        .security_control_id = "SecurityControlId",
    };
};
