/// A structure that contains information about a tag.
pub const Tag = struct {
    /// The key identifier, or name, of the tag.
    key: ?[]const u8 = null,

    /// The string value associated with the key of the tag.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
