/// Represents a tag.
pub const TagFilter = struct {
    /// The tag key.
    key: ?[]const u8 = null,

    /// The tag values (0 to 20).
    values: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .key = "Key",
        .values = "Values",
    };
};
