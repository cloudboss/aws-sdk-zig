/// A summary of the metrics of a trial component.
pub const TrialComponentMetricSummary = struct {
    /// The average value of the metric.
    avg: ?f64 = null,

    /// The number of samples used to generate the metric.
    count: ?i32 = null,

    /// The most recent value of the metric.
    last: ?f64 = null,

    /// The maximum value of the metric.
    max: ?f64 = null,

    /// The name of the metric.
    metric_name: ?[]const u8 = null,

    /// The minimum value of the metric.
    min: ?f64 = null,

    /// The Amazon Resource Name (ARN) of the source.
    source_arn: ?[]const u8 = null,

    /// The standard deviation of the metric.
    std_dev: ?f64 = null,

    /// When the metric was last updated.
    time_stamp: ?i64 = null,

    pub const json_field_names = .{
        .avg = "Avg",
        .count = "Count",
        .last = "Last",
        .max = "Max",
        .metric_name = "MetricName",
        .min = "Min",
        .source_arn = "SourceArn",
        .std_dev = "StdDev",
        .time_stamp = "TimeStamp",
    };
};
