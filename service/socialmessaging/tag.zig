/// The tag for a resource.
pub const Tag = struct {
    /// The tag key.
    key: []const u8,

    /// The tag value.
    value: ?[]const u8,

    pub const json_field_names = .{
        .key = "key",
        .value = "value",
    };
};
