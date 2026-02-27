/// A custom key-value pair that's associated with a resource.
pub const Tag = struct {
    /// The key identifier, or name, of the tag.
    key: []const u8,

    /// The string value that's associated with the key of the tag. You can set the
    /// value of a tag
    /// to an empty string, but you can't set the value of a tag to null.
    value: []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
