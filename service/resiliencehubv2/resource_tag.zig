/// A tag key-value pair used for resource discovery.
pub const ResourceTag = struct {
    key: []const u8,

    /// The list of tag values.
    values: []const []const u8,

    pub const json_field_names = .{
        .key = "key",
        .values = "values",
    };
};
