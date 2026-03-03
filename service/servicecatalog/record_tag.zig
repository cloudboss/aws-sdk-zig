/// Information about a tag, which is a key-value pair.
pub const RecordTag = struct {
    /// The key for this tag.
    key: ?[]const u8 = null,

    /// The value for this tag.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
