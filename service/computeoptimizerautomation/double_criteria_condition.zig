const ComparisonOperator = @import("comparison_operator.zig").ComparisonOperator;

/// Defines a condition for filtering based on double/floating-point numeric
/// values with comparison operators.
pub const DoubleCriteriaCondition = struct {
    /// The comparison operator to use, such as equals, greater than, less than,
    /// etc.
    comparison: ?ComparisonOperator,

    /// The list of double values to compare against using the specified comparison
    /// operator.
    values: ?[]const f64,

    pub const json_field_names = .{
        .comparison = "comparison",
        .values = "values",
    };
};
