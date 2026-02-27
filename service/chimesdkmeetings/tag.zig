/// A key-value pair that you define.
pub const Tag = struct {
    /// The tag's key.
    key: []const u8,

    /// The tag's value.
    value: []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
