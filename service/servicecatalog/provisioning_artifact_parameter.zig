const ParameterConstraints = @import("parameter_constraints.zig").ParameterConstraints;

/// Information about a parameter used to provision a product.
pub const ProvisioningArtifactParameter = struct {
    /// The default value.
    default_value: ?[]const u8,

    /// The description of the parameter.
    description: ?[]const u8,

    /// If this value is true, the value for this parameter is obfuscated from view
    /// when the
    /// parameter is retrieved. This parameter is used to hide sensitive
    /// information.
    is_no_echo: bool = false,

    /// Constraints that the administrator has put on a parameter.
    parameter_constraints: ?ParameterConstraints,

    /// The parameter key.
    parameter_key: ?[]const u8,

    /// The parameter type.
    parameter_type: ?[]const u8,

    pub const json_field_names = .{
        .default_value = "DefaultValue",
        .description = "Description",
        .is_no_echo = "IsNoEcho",
        .parameter_constraints = "ParameterConstraints",
        .parameter_key = "ParameterKey",
        .parameter_type = "ParameterType",
    };
};
