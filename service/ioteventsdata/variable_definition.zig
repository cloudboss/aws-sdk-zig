/// The new value of the variable.
pub const VariableDefinition = struct {
    /// The name of the variable.
    name: []const u8,

    /// The new value of the variable.
    value: []const u8,

    pub const json_field_names = .{
        .name = "name",
        .value = "value",
    };
};
