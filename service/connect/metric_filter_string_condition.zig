const MetricFilterStringConditionComparison = @import("metric_filter_string_condition_comparison.zig").MetricFilterStringConditionComparison;

/// A string comparison condition for metric filters.
pub const MetricFilterStringCondition = struct {
    /// The comparison operator. Valid values: `MATCHES_ANY` (matches any of the
    /// specified values) | `MATCHES_NONE` (matches none of the specified values).
    comparison: MetricFilterStringConditionComparison,

    /// The string values to compare against.
    values: []const []const u8,

    pub const json_field_names = .{
        .comparison = "Comparison",
        .values = "Values",
    };
};
