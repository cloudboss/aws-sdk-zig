const MatchOption = @import("match_option.zig").MatchOption;

/// Specifies the values and match options for cost category-based filtering in
/// cost and usage queries.
pub const CostCategoryValues = struct {
    /// The key of the cost category to filter on.
    key: ?[]const u8 = null,

    /// The match options for cost category values, such as `EQUALS`, `CONTAINS`,
    /// `STARTS_WITH`, or `ENDS_WITH`.
    match_options: ?[]const MatchOption = null,

    /// The values to match for the specified cost category key.
    values: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .key = "key",
        .match_options = "matchOptions",
        .values = "values",
    };
};
