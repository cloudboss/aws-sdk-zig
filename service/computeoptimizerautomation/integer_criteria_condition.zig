const ComparisonOperator = @import("comparison_operator.zig").ComparisonOperator;

/// Defines a condition for filtering based on integer values with comparison
/// operators.
pub const IntegerCriteriaCondition = struct {
    /// The comparison operator used to evaluate the attribute against the specified
    /// values.
    comparison: ?ComparisonOperator = null,

    /// The list of integer values to compare against using the specified comparison
    /// operator.
    values: ?[]const i32 = null,

    pub const json_field_names = .{
        .comparison = "comparison",
        .values = "values",
    };
};
