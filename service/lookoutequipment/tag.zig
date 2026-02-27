/// A tag is a key-value pair that can be added to a resource as metadata.
pub const Tag = struct {
    /// The key for the specified tag.
    key: []const u8,

    /// The value for the specified tag.
    value: []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
