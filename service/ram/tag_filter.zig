/// A tag key and optional list of possible values that you can use to filter
/// results for
/// tagged resources.
///
/// Multiple tag filters are evaluated as an OR condition.
pub const TagFilter = struct {
    /// The tag key. This must have a valid string value and can't be empty.
    tag_key: ?[]const u8 = null,

    /// A list of zero or more tag values. If no values are provided, then the
    /// filter matches
    /// any tag with the specified key, regardless of its value.
    tag_values: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .tag_key = "tagKey",
        .tag_values = "tagValues",
    };
};
