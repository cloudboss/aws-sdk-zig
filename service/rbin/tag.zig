/// Information about the tags to assign to the retention rule.
pub const Tag = struct {
    /// The tag key.
    key: []const u8,

    /// The tag value.
    value: []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
