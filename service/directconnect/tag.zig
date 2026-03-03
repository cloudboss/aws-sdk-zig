/// Information about a tag.
pub const Tag = struct {
    /// The key.
    key: []const u8,

    /// The value.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .key = "key",
        .value = "value",
    };
};
