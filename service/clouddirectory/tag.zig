/// The tag structure that contains a tag key and value.
pub const Tag = struct {
    /// The key that is associated with the tag.
    key: ?[]const u8 = null,

    /// The value that is associated with the tag.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
