/// A map of key-value pairs.
pub const Tag = struct {
    /// The key to use in the tag.
    key: []const u8,

    /// The value of the tag.
    value: []const u8,

    pub const json_field_names = .{
        .key = "key",
        .value = "value",
    };
};
