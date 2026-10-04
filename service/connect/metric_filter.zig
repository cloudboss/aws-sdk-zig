const MetricFilterBooleanCondition = @import("metric_filter_boolean_condition.zig").MetricFilterBooleanCondition;
const MetricFilterNumberCondition = @import("metric_filter_number_condition.zig").MetricFilterNumberCondition;
const MetricFilterStringCondition = @import("metric_filter_string_condition.zig").MetricFilterStringCondition;

/// A filter condition applied to a metric component in a calculation. Filters
/// restrict the data included in the metric computation.
pub const MetricFilter = struct {
    /// A boolean comparison condition.
    boolean_condition: ?MetricFilterBooleanCondition = null,

    /// The key identifying the field to filter on.
    metric_filter_key: []const u8,

    /// Specifies whether the filter condition is negated. When set to `true`, the
    /// filter excludes matching data instead of including it.
    negate: bool = false,

    /// A numeric comparison condition.
    number_condition: ?MetricFilterNumberCondition = null,

    /// A string comparison condition.
    string_condition: ?MetricFilterStringCondition = null,

    pub const json_field_names = .{
        .boolean_condition = "BooleanCondition",
        .metric_filter_key = "MetricFilterKey",
        .negate = "Negate",
        .number_condition = "NumberCondition",
        .string_condition = "StringCondition",
    };
};
