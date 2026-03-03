const ParameterConstraints = @import("parameter_constraints.zig").ParameterConstraints;

/// The `ParameterDeclaration` data type.
pub const ParameterDeclaration = struct {
    /// The default value of the parameter.
    default_value: ?[]const u8 = null,

    /// The description that's associate with the parameter.
    description: ?[]const u8 = null,

    /// Flag that indicates whether the parameter value is shown as plain text in
    /// logs and in the
    /// Amazon Web Services Management Console.
    no_echo: ?bool = null,

    /// The criteria that CloudFormation uses to validate parameter values.
    parameter_constraints: ?ParameterConstraints = null,

    /// The name that's associated with the parameter.
    parameter_key: ?[]const u8 = null,

    /// The type of parameter.
    parameter_type: ?[]const u8 = null,
};
