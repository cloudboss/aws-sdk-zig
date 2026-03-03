const SimpleTotalAggregationFunction = @import("simple_total_aggregation_function.zig").SimpleTotalAggregationFunction;

/// An aggregation function that aggregates the total values of a measure.
pub const TotalAggregationFunction = struct {
    /// A built in aggregation function for total values.
    simple_total_aggregation_function: ?SimpleTotalAggregationFunction = null,

    pub const json_field_names = .{
        .simple_total_aggregation_function = "SimpleTotalAggregationFunction",
    };
};
