const ComparisonOperator = @import("comparison_operator.zig").ComparisonOperator;

/// Criteria condition for filtering resources based on their tags, including
/// comparison operators and values.
pub const ResourceTagsCriteriaCondition = struct {
    /// The comparison operator used to evaluate the tag criteria, such as equals,
    /// not equals, or contains.
    comparison: ?ComparisonOperator,

    /// The tag key to use for comparison when filtering resources.
    key: ?[]const u8,

    /// List of tag values to compare against when filtering resources.
    values: ?[]const []const u8,

    pub const json_field_names = .{
        .comparison = "comparison",
        .key = "key",
        .values = "values",
    };
};
