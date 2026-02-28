/// The metric to optimize during hyperparameter optimization (HPO).
///
/// Amazon Personalize doesn't support configuring the `hpoObjective`
/// at this time.
pub const HPOObjective = struct {
    /// The name of the metric.
    metric_name: ?[]const u8,

    /// A regular expression for finding the metric in the training job logs.
    metric_regex: ?[]const u8,

    /// The type of the metric. Valid values are `Maximize` and `Minimize`.
    @"type": ?[]const u8,

    pub const json_field_names = .{
        .metric_name = "metricName",
        .metric_regex = "metricRegex",
        .@"type" = "type",
    };
};
