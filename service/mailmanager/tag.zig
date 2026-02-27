/// A key-value pair (the value is optional), that you can define and assign to
/// Amazon Web Services resources.
pub const Tag = struct {
    /// The key of the key-value tag.
    key: []const u8,

    /// The value of the key-value tag.
    value: []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
