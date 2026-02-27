/// The name and ARN of a fleet metric.
pub const FleetMetricNameAndArn = struct {
    /// The fleet metric ARN.
    metric_arn: ?[]const u8,

    /// The fleet metric name.
    metric_name: ?[]const u8,

    pub const json_field_names = .{
        .metric_arn = "metricArn",
        .metric_name = "metricName",
    };
};
