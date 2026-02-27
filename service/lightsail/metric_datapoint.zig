const MetricUnit = @import("metric_unit.zig").MetricUnit;

/// Describes the metric data point.
pub const MetricDatapoint = struct {
    /// The average.
    average: ?f64,

    /// The maximum.
    maximum: ?f64,

    /// The minimum.
    minimum: ?f64,

    /// The sample count.
    sample_count: ?f64,

    /// The sum.
    sum: ?f64,

    /// The timestamp (`1479816991.349`).
    timestamp: ?i64,

    /// The unit.
    unit: ?MetricUnit,

    pub const json_field_names = .{
        .average = "average",
        .maximum = "maximum",
        .minimum = "minimum",
        .sample_count = "sampleCount",
        .sum = "sum",
        .timestamp = "timestamp",
        .unit = "unit",
    };
};
