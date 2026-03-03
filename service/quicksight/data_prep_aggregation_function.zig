const DataPrepListAggregationFunction = @import("data_prep_list_aggregation_function.zig").DataPrepListAggregationFunction;
const DataPrepSimpleAggregationFunction = @import("data_prep_simple_aggregation_function.zig").DataPrepSimpleAggregationFunction;

/// Defines the type of aggregation function to apply to data during data
/// preparation, supporting simple
/// and list aggregations.
pub const DataPrepAggregationFunction = struct {
    /// A list aggregation function that concatenates values from multiple rows into
    /// a single delimited string.
    list_aggregation: ?DataPrepListAggregationFunction = null,

    /// A simple aggregation function such as `SUM`, `COUNT`, `AVERAGE`,
    /// `MIN`, `MAX`, `MEDIAN`, `VARIANCE`, or `STANDARD_DEVIATION`.
    simple_aggregation: ?DataPrepSimpleAggregationFunction = null,

    pub const json_field_names = .{
        .list_aggregation = "ListAggregation",
        .simple_aggregation = "SimpleAggregation",
    };
};
