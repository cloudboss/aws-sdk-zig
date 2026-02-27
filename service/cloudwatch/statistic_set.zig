/// Represents a set of statistics that describes a specific metric.
pub const StatisticSet = struct {
    /// The maximum value of the sample set.
    maximum: f64,

    /// The minimum value of the sample set.
    minimum: f64,

    /// The number of samples used for the statistic set.
    sample_count: f64,

    /// The sum of values for the sample set.
    sum: f64,

    pub const json_field_names = .{
        .maximum = "Maximum",
        .minimum = "Minimum",
        .sample_count = "SampleCount",
        .sum = "Sum",
    };
};
