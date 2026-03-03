const PercentileAggregation = @import("percentile_aggregation.zig").PercentileAggregation;
const SimpleNumericalAggregationFunction = @import("simple_numerical_aggregation_function.zig").SimpleNumericalAggregationFunction;

/// Aggregation for numerical values.
pub const NumericalAggregationFunction = struct {
    /// An aggregation based on the percentile of values in a dimension or measure.
    percentile_aggregation: ?PercentileAggregation = null,

    /// Built-in aggregation functions for numerical values.
    ///
    /// * `SUM`: The sum of a dimension or measure.
    ///
    /// * `AVERAGE`: The average of a dimension or measure.
    ///
    /// * `MIN`: The minimum value of a dimension or measure.
    ///
    /// * `MAX`: The maximum value of a dimension or measure.
    ///
    /// * `COUNT`: The count of a dimension or measure.
    ///
    /// * `DISTINCT_COUNT`: The count of distinct values in a dimension or measure.
    ///
    /// * `VAR`: The variance of a dimension or measure.
    ///
    /// * `VARP`: The partitioned variance of a dimension or measure.
    ///
    /// * `STDEV`: The standard deviation of a dimension or measure.
    ///
    /// * `STDEVP`: The partitioned standard deviation of a dimension or measure.
    ///
    /// * `MEDIAN`: The median value of a dimension or measure.
    simple_numerical_aggregation: ?SimpleNumericalAggregationFunction = null,

    pub const json_field_names = .{
        .percentile_aggregation = "PercentileAggregation",
        .simple_numerical_aggregation = "SimpleNumericalAggregation",
    };
};
