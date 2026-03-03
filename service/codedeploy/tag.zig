/// Information about a tag.
pub const Tag = struct {
    /// The tag's key.
    key: ?[]const u8 = null,

    /// The tag's value.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
