/// The values that are available for a tag.
pub const TagValues = struct {
    /// The key for the tag.
    key: []const u8,

    /// The specific value of the tag.
    values: []const []const u8,

    pub const json_field_names = .{
        .key = "key",
        .values = "values",
    };
};
