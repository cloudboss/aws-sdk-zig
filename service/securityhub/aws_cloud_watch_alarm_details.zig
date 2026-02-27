const AwsCloudWatchAlarmDimensionsDetails = @import("aws_cloud_watch_alarm_dimensions_details.zig").AwsCloudWatchAlarmDimensionsDetails;

/// Specifies an alarm and associates it with the specified metric or metric
/// math expression.
pub const AwsCloudWatchAlarmDetails = struct {
    /// Indicates whether actions should be executed during any changes to the alarm
    /// state.
    actions_enabled: ?bool,

    /// The list of actions, specified as Amazon Resource Names (ARNs) to execute
    /// when this alarm transitions into an `ALARM` state from any other
    /// state.
    alarm_actions: ?[]const []const u8,

    /// The ARN of the alarm.
    alarm_arn: ?[]const u8,

    /// The time stamp of the last update to the alarm configuration.
    alarm_configuration_updated_timestamp: ?[]const u8,

    /// The description of the alarm.
    alarm_description: ?[]const u8,

    /// The name of the alarm. If you don't specify a name, CloudFront generates a
    /// unique physical ID
    /// and uses that ID for the alarm name.
    alarm_name: ?[]const u8,

    /// The arithmetic operation to use when comparing the specified statistic and
    /// threshold. The specified
    /// statistic value is used as the first operand.
    comparison_operator: ?[]const u8,

    /// The number of datapoints that must be breaching to trigger the alarm.
    datapoints_to_alarm: ?i32,

    /// The dimensions for the metric associated with the alarm.
    dimensions: ?[]const AwsCloudWatchAlarmDimensionsDetails,

    /// Used only for alarms based on percentiles. If `ignore`, the alarm state does
    /// not change during
    /// periods with too few data points to be statistically significant. If
    /// `evaluate` or this parameter is not used,
    /// the alarm is always evaluated and possibly changes state no matter how many
    /// data points are available.
    evaluate_low_sample_count_percentile: ?[]const u8,

    /// The number of periods over which data is compared to the specified
    /// threshold.
    evaluation_periods: ?i32,

    /// The percentile statistic for the metric associated with the alarm.
    extended_statistic: ?[]const u8,

    /// The actions to execute when this alarm transitions to the
    /// `INSUFFICIENT_DATA` state from
    /// any other state. Each action is specified as an ARN.
    insufficient_data_actions: ?[]const []const u8,

    /// The name of the metric associated with the alarm. This is required for an
    /// alarm based on a metric.
    /// For an alarm based on a math expression, you use `Metrics` instead and you
    /// can't specify `MetricName`.
    metric_name: ?[]const u8,

    /// The namespace of the metric associated with the alarm. This is required for
    /// an alarm based on a
    /// metric. For an alarm based on a math expression, you can't specify
    /// `Namespace` and you use
    /// `Metrics` instead.
    namespace: ?[]const u8,

    /// The actions to execute when this alarm transitions to the `OK` state from
    /// any other state.
    /// Each action is specified as an ARN.
    ok_actions: ?[]const []const u8,

    /// The period, in seconds, over which the statistic is applied. This is
    /// required for an alarm based on a
    /// metric.
    period: ?i32,

    /// The statistic for the metric associated with the alarm, other than
    /// percentile. For percentile statistics, use `ExtendedStatistic`.
    ///
    /// For an alarm based on a metric, you must specify either `Statistic` or
    /// `ExtendedStatistic` but not both.
    ///
    /// For an alarm based on a math expression, you can't specify `Statistic`.
    /// Instead, you use `Metrics`.
    statistic: ?[]const u8,

    /// The value to compare with the specified statistic.
    threshold: ?f64,

    /// n an alarm based on an anomaly detection model, this is the ID of the
    /// `ANOMALY_DETECTION_BAND` function used as the threshold for the alarm.
    threshold_metric_id: ?[]const u8,

    /// Sets how this alarm is to handle missing data points.
    treat_missing_data: ?[]const u8,

    /// The unit of the metric associated with the alarm.
    unit: ?[]const u8,

    pub const json_field_names = .{
        .actions_enabled = "ActionsEnabled",
        .alarm_actions = "AlarmActions",
        .alarm_arn = "AlarmArn",
        .alarm_configuration_updated_timestamp = "AlarmConfigurationUpdatedTimestamp",
        .alarm_description = "AlarmDescription",
        .alarm_name = "AlarmName",
        .comparison_operator = "ComparisonOperator",
        .datapoints_to_alarm = "DatapointsToAlarm",
        .dimensions = "Dimensions",
        .evaluate_low_sample_count_percentile = "EvaluateLowSampleCountPercentile",
        .evaluation_periods = "EvaluationPeriods",
        .extended_statistic = "ExtendedStatistic",
        .insufficient_data_actions = "InsufficientDataActions",
        .metric_name = "MetricName",
        .namespace = "Namespace",
        .ok_actions = "OkActions",
        .period = "Period",
        .statistic = "Statistic",
        .threshold = "Threshold",
        .threshold_metric_id = "ThresholdMetricId",
        .treat_missing_data = "TreatMissingData",
        .unit = "Unit",
    };
};
