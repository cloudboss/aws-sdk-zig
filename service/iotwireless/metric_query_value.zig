/// The aggregated values of the metric.
pub const MetricQueryValue = struct {
    /// The average of the values of all data points collected during the
    /// aggregation
    /// period.
    avg: ?f64 = null,

    /// The maximum of the values of all the data points collected during the
    /// aggregation
    /// period.
    max: ?f64 = null,

    /// The minimum of the values of all data points collected during the
    /// aggregation
    /// period.
    min: ?f64 = null,

    /// The 90th percentile of the values of all data points collected during the
    /// aggregation
    /// period.
    p90: ?f64 = null,

    /// The standard deviation of the values of all data points collected during the
    /// aggregation period.
    std: ?f64 = null,

    /// The sum of the values of all data points collected during the aggregation
    /// period.
    sum: ?f64 = null,

    pub const json_field_names = .{
        .avg = "Avg",
        .max = "Max",
        .min = "Min",
        .p90 = "P90",
        .std = "Std",
        .sum = "Sum",
    };
};
