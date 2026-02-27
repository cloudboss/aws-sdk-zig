/// Contains a tag. A tag is a key-value pair.
pub const Tag = struct {
    /// The key of the tag.
    key: []const u8,

    /// The value of the tag.
    value: []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
