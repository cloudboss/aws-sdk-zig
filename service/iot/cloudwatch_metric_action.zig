/// Describes an action that captures a CloudWatch metric.
pub const CloudwatchMetricAction = struct {
    /// The CloudWatch metric name.
    metric_name: []const u8,

    /// The CloudWatch metric namespace name.
    metric_namespace: []const u8,

    /// An optional [Unix
    /// timestamp](https://docs.aws.amazon.com/AmazonCloudWatch/latest/DeveloperGuide/cloudwatch_concepts.html#about_timestamp).
    metric_timestamp: ?[]const u8,

    /// The [metric
    /// unit](https://docs.aws.amazon.com/AmazonCloudWatch/latest/DeveloperGuide/cloudwatch_concepts.html#Unit) supported by CloudWatch.
    metric_unit: []const u8,

    /// The CloudWatch metric value.
    metric_value: []const u8,

    /// The IAM role that allows access to the CloudWatch metric.
    role_arn: []const u8,

    pub const json_field_names = .{
        .metric_name = "metricName",
        .metric_namespace = "metricNamespace",
        .metric_timestamp = "metricTimestamp",
        .metric_unit = "metricUnit",
        .metric_value = "metricValue",
        .role_arn = "roleArn",
    };
};
