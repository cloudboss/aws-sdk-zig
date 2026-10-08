/// Describes a change from one string value to another.
pub const StringChange = struct {
    /// The new value.
    new_value: ?[]const u8 = null,

    /// The old value.
    old_value: ?[]const u8 = null,

    pub const json_field_names = .{
        .new_value = "newValue",
        .old_value = "oldValue",
    };
};
