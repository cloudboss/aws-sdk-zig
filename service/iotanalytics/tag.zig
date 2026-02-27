/// A set of key-value pairs that are used to manage the resource.
pub const Tag = struct {
    /// The tag's key.
    key: []const u8,

    /// The tag's value.
    value: []const u8,

    pub const json_field_names = .{
        .key = "key",
        .value = "value",
    };
};
