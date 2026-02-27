/// Specifies the default value to use when a user doesn't provide a
/// value for a slot.
pub const SlotDefaultValue = struct {
    /// The default value to use when a user doesn't provide a value for a
    /// slot.
    default_value: []const u8,

    pub const json_field_names = .{
        .default_value = "defaultValue",
    };
};
