const ComparisonOperator = @import("comparison_operator.zig").ComparisonOperator;

/// Criteria condition for filtering based on string values, including
/// comparison operators and target values.
pub const StringCriteriaCondition = struct {
    /// The comparison operator used to evaluate the string criteria, such as
    /// equals, not equals, or contains.
    comparison: ?ComparisonOperator = null,

    /// List of string values to compare against when applying the criteria
    /// condition.
    values: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .comparison = "comparison",
        .values = "values",
    };
};
