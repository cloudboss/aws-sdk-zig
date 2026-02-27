/// The current state of the variable.
pub const Variable = struct {
    /// The name of the variable.
    name: []const u8,

    /// The current value of the variable.
    value: []const u8,

    pub const json_field_names = .{
        .name = "name",
        .value = "value",
    };
};
