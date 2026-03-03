const aws = @import("aws");

const StandardUnit = @import("standard_unit.zig").StandardUnit;

/// Encapsulates the statistical data that CloudWatch computes from metric
/// data.
pub const Datapoint = struct {
    /// The average of the metric values that correspond to the data point.
    average: ?f64 = null,

    /// The percentile statistic for the data point.
    extended_statistics: ?[]const aws.map.MapEntry(f64) = null,

    /// The maximum metric value for the data point.
    maximum: ?f64 = null,

    /// The minimum metric value for the data point.
    minimum: ?f64 = null,

    /// The number of metric values that contributed to the aggregate value of this
    /// data
    /// point.
    sample_count: ?f64 = null,

    /// The sum of the metric values for the data point.
    sum: ?f64 = null,

    /// The time stamp used for the data point.
    timestamp: ?i64 = null,

    /// The standard unit for the data point.
    unit: ?StandardUnit = null,

    pub const json_field_names = .{
        .average = "Average",
        .extended_statistics = "ExtendedStatistics",
        .maximum = "Maximum",
        .minimum = "Minimum",
        .sample_count = "SampleCount",
        .sum = "Sum",
        .timestamp = "Timestamp",
        .unit = "Unit",
    };
};
