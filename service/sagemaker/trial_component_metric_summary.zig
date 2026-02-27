/// A summary of the metrics of a trial component.
pub const TrialComponentMetricSummary = struct {
    /// The average value of the metric.
    avg: ?f64,

    /// The number of samples used to generate the metric.
    count: ?i32,

    /// The most recent value of the metric.
    last: ?f64,

    /// The maximum value of the metric.
    max: ?f64,

    /// The name of the metric.
    metric_name: ?[]const u8,

    /// The minimum value of the metric.
    min: ?f64,

    /// The Amazon Resource Name (ARN) of the source.
    source_arn: ?[]const u8,

    /// The standard deviation of the metric.
    std_dev: ?f64,

    /// When the metric was last updated.
    time_stamp: ?i64,

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
