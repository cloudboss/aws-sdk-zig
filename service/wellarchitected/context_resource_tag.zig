/// A key-value pair representing a resource tag used to scope context content.
pub const ContextResourceTag = struct {
    /// The tag key.
    key: []const u8,

    /// The tag value.
    value: []const u8,

    pub const json_field_names = .{
        .key = "key",
        .value = "value",
    };
};
