/// A container of a key-value name pair.
pub const Tag = struct {
    /// Name of the object key.
    key: ?[]const u8 = null,

    /// Value of the tag.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
