/// A complex type that contains a `Tag` key and `Tag` value.
pub const Tag = struct {
    /// A string that contains a `Tag` key.
    key: []const u8,

    /// A string that contains a `Tag` value.
    value: []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
