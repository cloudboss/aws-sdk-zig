const MetricFilterBooleanConditionComparison = @import("metric_filter_boolean_condition_comparison.zig").MetricFilterBooleanConditionComparison;

/// A boolean comparison condition for metric filters.
pub const MetricFilterBooleanCondition = struct {
    /// The comparison operator. Valid values: `IS_TRUE` (matches when the field is
    /// true) | `IS_FALSE` (matches when the field is false).
    comparison: MetricFilterBooleanConditionComparison,

    pub const json_field_names = .{
        .comparison = "Comparison",
    };
};
