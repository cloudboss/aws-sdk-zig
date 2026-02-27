/// Information about the variable and its new value.
pub const SetVariableAction = struct {
    /// The new value of the variable.
    value: []const u8,

    /// The name of the variable.
    variable_name: []const u8,

    pub const json_field_names = .{
        .value = "value",
        .variable_name = "variableName",
    };
};
