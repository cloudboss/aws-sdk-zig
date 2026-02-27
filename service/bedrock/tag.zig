/// Definition of the key/value pair for a tag.
pub const Tag = struct {
    /// Key for the tag.
    key: []const u8,

    /// Value for the tag.
    value: []const u8,

    pub const json_field_names = .{
        .key = "key",
        .value = "value",
    };
};
