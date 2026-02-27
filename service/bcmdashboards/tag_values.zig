const MatchOption = @import("match_option.zig").MatchOption;

/// Specifies tag-based filtering options for cost and usage queries.
pub const TagValues = struct {
    /// The key of the tag to filter on.
    key: ?[]const u8,

    /// The match options for tag values, such as `EQUALS`, `CONTAINS`,
    /// `STARTS_WITH`, or `ENDS_WITH`.
    match_options: ?[]const MatchOption,

    /// The values to match for the specified tag key.
    values: ?[]const []const u8,

    pub const json_field_names = .{
        .key = "key",
        .match_options = "matchOptions",
        .values = "values",
    };
};
