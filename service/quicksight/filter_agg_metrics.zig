const AggType = @import("agg_type.zig").AggType;
const Identifier = @import("identifier.zig").Identifier;
const TopicSortDirection = @import("topic_sort_direction.zig").TopicSortDirection;

/// The definition for the `FilterAggMetrics`.
pub const FilterAggMetrics = struct {
    /// The function for the `FilterAggMetrics`.
    function: ?AggType = null,

    /// The metric operand of the `FilterAggMetrics`.
    metric_operand: ?Identifier = null,

    /// The sort direction for `FilterAggMetrics`.
    sort_direction: ?TopicSortDirection = null,

    pub const json_field_names = .{
        .function = "Function",
        .metric_operand = "MetricOperand",
        .sort_direction = "SortDirection",
    };
};
