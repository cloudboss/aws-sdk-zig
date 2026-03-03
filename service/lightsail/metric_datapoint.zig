const MetricUnit = @import("metric_unit.zig").MetricUnit;

/// Describes the metric data point.
pub const MetricDatapoint = struct {
    /// The average.
    average: ?f64 = null,

    /// The maximum.
    maximum: ?f64 = null,

    /// The minimum.
    minimum: ?f64 = null,

    /// The sample count.
    sample_count: ?f64 = null,

    /// The sum.
    sum: ?f64 = null,

    /// The timestamp (`1479816991.349`).
    timestamp: ?i64 = null,

    /// The unit.
    unit: ?MetricUnit = null,

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
