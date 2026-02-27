const aws = @import("aws");

const FilterAggMetrics = @import("filter_agg_metrics.zig").FilterAggMetrics;
const AggType = @import("agg_type.zig").AggType;
const AggregationPartitionBy = @import("aggregation_partition_by.zig").AggregationPartitionBy;
const Anchor = @import("anchor.zig").Anchor;
const TopicConstantValue = @import("topic_constant_value.zig").TopicConstantValue;
const FilterClass = @import("filter_class.zig").FilterClass;
const TopicIRFilterType = @import("topic_ir_filter_type.zig").TopicIRFilterType;
const TopicIRFilterFunction = @import("topic_ir_filter_function.zig").TopicIRFilterFunction;
const NullFilterOption = @import("null_filter_option.zig").NullFilterOption;
const Identifier = @import("identifier.zig").Identifier;
const TopicSortDirection = @import("topic_sort_direction.zig").TopicSortDirection;
const TimeGranularity = @import("time_granularity.zig").TimeGranularity;

/// The definition for a `TopicIRFilterOption`.
pub const TopicIRFilterOption = struct {
    /// The agg metrics for the `TopicIRFilterOption`.
    agg_metrics: ?[]const FilterAggMetrics,

    /// The aggregation for the `TopicIRFilterOption`.
    aggregation: ?AggType,

    /// The aggregation function parameters for the `TopicIRFilterOption`.
    aggregation_function_parameters: ?[]const aws.map.StringMapEntry,

    /// The `AggregationPartitionBy` for the `TopicIRFilterOption`.
    aggregation_partition_by: ?[]const AggregationPartitionBy,

    /// The anchor for the `TopicIRFilterOption`.
    anchor: ?Anchor,

    /// The constant for the `TopicIRFilterOption`.
    constant: ?TopicConstantValue,

    /// The filter class for the `TopicIRFilterOption`.
    filter_class: ?FilterClass,

    /// The filter type for the `TopicIRFilterOption`.
    filter_type: ?TopicIRFilterType,

    /// The function for the `TopicIRFilterOption`.
    function: ?TopicIRFilterFunction,

    /// The inclusive for the `TopicIRFilterOption`.
    inclusive: bool = false,

    /// The inverse for the `TopicIRFilterOption`.
    inverse: bool = false,

    /// The last next offset for the `TopicIRFilterOption`.
    last_next_offset: ?TopicConstantValue,

    /// The null filter for the `TopicIRFilterOption`.
    null_filter: ?NullFilterOption,

    /// The operand field for the `TopicIRFilterOption`.
    operand_field: ?Identifier,

    /// The range for the `TopicIRFilterOption`.
    range: ?TopicConstantValue,

    /// The sort direction for the `TopicIRFilterOption`.
    sort_direction: ?TopicSortDirection,

    /// The time granularity for the `TopicIRFilterOption`.
    time_granularity: ?TimeGranularity,

    /// The `TopBottomLimit` for the `TopicIRFilterOption`.
    top_bottom_limit: ?TopicConstantValue,

    pub const json_field_names = .{
        .agg_metrics = "AggMetrics",
        .aggregation = "Aggregation",
        .aggregation_function_parameters = "AggregationFunctionParameters",
        .aggregation_partition_by = "AggregationPartitionBy",
        .anchor = "Anchor",
        .constant = "Constant",
        .filter_class = "FilterClass",
        .filter_type = "FilterType",
        .function = "Function",
        .inclusive = "Inclusive",
        .inverse = "Inverse",
        .last_next_offset = "LastNextOffset",
        .null_filter = "NullFilter",
        .operand_field = "OperandField",
        .range = "Range",
        .sort_direction = "SortDirection",
        .time_granularity = "TimeGranularity",
        .top_bottom_limit = "TopBottomLimit",
    };
};
