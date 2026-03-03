const VariableValue = @import("variable_value.zig").VariableValue;

/// This structure contains the name and variation value of one variation of a
/// feature.
pub const Variation = struct {
    /// The name of the variation.
    name: ?[]const u8 = null,

    /// The value assigned to this variation.
    value: ?VariableValue = null,

    pub const json_field_names = .{
        .name = "name",
        .value = "value",
    };
};
