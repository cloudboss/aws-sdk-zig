const MetricFilterNumberConditionComparison = @import("metric_filter_number_condition_comparison.zig").MetricFilterNumberConditionComparison;

/// A numeric comparison condition for metric filters.
pub const MetricFilterNumberCondition = struct {
    /// The comparison operator. Valid values: `LESSER` (less than) |
    /// `LESSER_OR_EQUAL` (less than or equal to) | `GREATER` (greater than) |
    /// `GREATER_OR_EQUAL` (greater than or equal to).
    comparison: MetricFilterNumberConditionComparison,

    /// The numeric values to compare against.
    values: []const f64,

    pub const json_field_names = .{
        .comparison = "Comparison",
        .values = "Values",
    };
};
