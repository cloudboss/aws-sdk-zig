/// The tag structure that contains a tag key and value.
pub const Tag = struct {
    /// The key that's associated with the tag.
    key: ?[]const u8,

    /// The value that's associated with the tag.
    value: ?[]const u8,

    pub const json_field_names = .{
        .key = "key",
        .value = "value",
    };
};
