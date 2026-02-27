const VariableValue = @import("variable_value.zig").VariableValue;

/// Contains expression variable information.
pub const ExpressionVariable = struct {
    /// The friendly name of the variable to be used in the expression.
    name: []const u8,

    /// The variable that identifies an asset property from which to use values.
    value: VariableValue,

    pub const json_field_names = .{
        .name = "name",
        .value = "value",
    };
};
