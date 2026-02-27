const VariableType = @import("variable_type.zig").VariableType;

/// The dynamic SSM parameter value.
pub const DynamicSsmParameterValue = union(enum) {
    /// Variable dynamic parameters. A parameter value is determined when an
    /// incident is
    /// created.
    variable: ?VariableType,

    pub const json_field_names = .{
        .variable = "variable",
    };
};
