/// A key and value pair.
pub const Tag = struct {
    /// A tag key.
    key: []const u8,

    /// A value assigned to a tag key.
    value: []const u8,

    pub const json_field_names = .{
        .key = "key",
        .value = "value",
    };
};
