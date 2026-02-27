/// A tag object containing a key-value pair.
pub const Tag = struct {
    /// The key in a tag.
    key: []const u8,

    /// The value in a tag.
    value: []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
