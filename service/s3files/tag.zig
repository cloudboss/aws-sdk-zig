/// A key-value pair for resource tagging.
pub const Tag = struct {
    /// The tag key. The key can't start with `aws:`.
    key: []const u8,

    /// The tag value.
    value: []const u8,

    pub const json_field_names = .{
        .key = "key",
        .value = "value",
    };
};
