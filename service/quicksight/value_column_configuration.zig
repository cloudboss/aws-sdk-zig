const DataPrepAggregationFunction = @import("data_prep_aggregation_function.zig").DataPrepAggregationFunction;

/// Configuration for how to handle value columns in pivot operations, including
/// aggregation settings.
pub const ValueColumnConfiguration = struct {
    /// The aggregation function to apply when multiple values map to the same
    /// pivoted cell.
    aggregation_function: ?DataPrepAggregationFunction,

    pub const json_field_names = .{
        .aggregation_function = "AggregationFunction",
    };
};
