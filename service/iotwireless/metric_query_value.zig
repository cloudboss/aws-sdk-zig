/// The aggregated values of the metric.
pub const MetricQueryValue = struct {
    /// The average of the values of all data points collected during the
    /// aggregation
    /// period.
    avg: ?f64,

    /// The maximum of the values of all the data points collected during the
    /// aggregation
    /// period.
    max: ?f64,

    /// The minimum of the values of all data points collected during the
    /// aggregation
    /// period.
    min: ?f64,

    /// The 90th percentile of the values of all data points collected during the
    /// aggregation
    /// period.
    p90: ?f64,

    /// The standard deviation of the values of all data points collected during the
    /// aggregation period.
    std: ?f64,

    /// The sum of the values of all data points collected during the aggregation
    /// period.
    sum: ?f64,

    pub const json_field_names = .{
        .avg = "Avg",
        .max = "Max",
        .min = "Min",
        .p90 = "P90",
        .std = "Std",
        .sum = "Sum",
    };
};
