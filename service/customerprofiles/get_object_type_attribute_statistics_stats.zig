const GetObjectTypeAttributeStatisticsPercentiles = @import("get_object_type_attribute_statistics_percentiles.zig").GetObjectTypeAttributeStatisticsPercentiles;

/// Statistical measurements for object type attributes including basic
/// statistics and percentiles.
pub const GetObjectTypeAttributeStatisticsStats = struct {
    /// The arithmetic mean of the attribute values.
    average: f64,

    /// The maximum value found in the attribute dataset.
    maximum: f64,

    /// The minimum value found in the attribute dataset.
    minimum: f64,

    /// Percentile distribution statistics for the attribute values.
    percentiles: GetObjectTypeAttributeStatisticsPercentiles,

    /// The standard deviation of the attribute values, measuring their spread
    /// around the mean.
    standard_deviation: f64,

    pub const json_field_names = .{
        .average = "Average",
        .maximum = "Maximum",
        .minimum = "Minimum",
        .percentiles = "Percentiles",
        .standard_deviation = "StandardDeviation",
    };
};
