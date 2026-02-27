/// An aggregation based on the percentile of values in a dimension or measure.
pub const PercentileAggregation = struct {
    /// The percentile value. This value can be any numeric constant 0–100. A
    /// percentile value of 50 computes the median value of the measure.
    percentile_value: ?f64,

    pub const json_field_names = .{
        .percentile_value = "PercentileValue",
    };
};
