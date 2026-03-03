/// **Internal only**. Represents a set of statistics that describe a specific
/// metric. To learn more about the metrics published to Amazon CloudWatch, see
/// [Amazon MWAA performance metrics in Amazon
/// CloudWatch](https://docs.aws.amazon.com/mwaa/latest/userguide/cw-metrics.html).
pub const StatisticSet = struct {
    /// **Internal only**. The maximum value of the sample set.
    maximum: ?f64 = null,

    /// **Internal only**. The minimum value of the sample set.
    minimum: ?f64 = null,

    /// **Internal only**. The number of samples used for the statistic set.
    sample_count: ?i32 = null,

    /// **Internal only**. The sum of values for the sample set.
    sum: ?f64 = null,

    pub const json_field_names = .{
        .maximum = "Maximum",
        .minimum = "Minimum",
        .sample_count = "SampleCount",
        .sum = "Sum",
    };
};
