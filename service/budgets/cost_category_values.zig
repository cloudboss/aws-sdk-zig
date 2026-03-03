const MatchOption = @import("match_option.zig").MatchOption;

/// The cost category values used for filtering the costs.
pub const CostCategoryValues = struct {
    /// The unique name of the cost category.
    key: ?[]const u8 = null,

    /// The match options that you can use to filter your results.
    match_options: ?[]const MatchOption = null,

    /// The specific value of the cost category.
    values: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .key = "Key",
        .match_options = "MatchOptions",
        .values = "Values",
    };
};
