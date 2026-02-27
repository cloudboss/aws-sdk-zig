/// The list of tags to be added to the specified topic.
pub const Tag = struct {
    /// The key identifier, or name, of the tag.
    key: []const u8,

    /// The string value associated with the key of the tag.
    value: []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
