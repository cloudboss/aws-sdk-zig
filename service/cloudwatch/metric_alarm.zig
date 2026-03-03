const ComparisonOperator = @import("comparison_operator.zig").ComparisonOperator;
const Dimension = @import("dimension.zig").Dimension;
const EvaluationState = @import("evaluation_state.zig").EvaluationState;
const MetricDataQuery = @import("metric_data_query.zig").MetricDataQuery;
const StateValue = @import("state_value.zig").StateValue;
const Statistic = @import("statistic.zig").Statistic;
const StandardUnit = @import("standard_unit.zig").StandardUnit;

/// The details about a metric alarm.
pub const MetricAlarm = struct {
    /// Indicates whether actions should be executed during any changes to the alarm
    /// state.
    actions_enabled: ?bool = null,

    /// The actions to execute when this alarm transitions to the `ALARM` state
    /// from any other state. Each action is specified as an Amazon Resource Name
    /// (ARN).
    alarm_actions: ?[]const []const u8 = null,

    /// The Amazon Resource Name (ARN) of the alarm.
    alarm_arn: ?[]const u8 = null,

    /// The time stamp of the last update to the alarm configuration.
    alarm_configuration_updated_timestamp: ?i64 = null,

    /// The description of the alarm.
    alarm_description: ?[]const u8 = null,

    /// The name of the alarm.
    alarm_name: ?[]const u8 = null,

    /// The arithmetic operation to use when comparing the specified statistic and
    /// threshold. The specified statistic value is used as the first operand.
    comparison_operator: ?ComparisonOperator = null,

    /// The number of data points that must be breaching to trigger the alarm.
    datapoints_to_alarm: ?i32 = null,

    /// The dimensions for the metric associated with the alarm.
    dimensions: ?[]const Dimension = null,

    /// Used only for alarms based on percentiles. If `ignore`, the alarm state
    /// does not change during periods with too few data points to be statistically
    /// significant.
    /// If `evaluate` or this parameter is not used, the alarm is always evaluated
    /// and possibly changes state no matter how many data points are available.
    evaluate_low_sample_count_percentile: ?[]const u8 = null,

    /// The number of periods over which data is compared to the specified
    /// threshold.
    evaluation_periods: ?i32 = null,

    /// If the value of this field is `PARTIAL_DATA`, the alarm is being evaluated
    /// based on only partial data. This happens if the query used for the alarm
    /// returns more
    /// than 10,000 metrics. For more information, see [Create
    /// alarms on Metrics Insights
    /// queries](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/Create_Metrics_Insights_Alarm.html).
    evaluation_state: ?EvaluationState = null,

    /// The percentile statistic for the metric associated with the alarm. Specify a
    /// value
    /// between p0.0 and p100.
    extended_statistic: ?[]const u8 = null,

    /// The actions to execute when this alarm transitions to the
    /// `INSUFFICIENT_DATA` state from any other state. Each action is specified
    /// as an Amazon Resource Name (ARN).
    insufficient_data_actions: ?[]const []const u8 = null,

    /// The name of the metric associated with the alarm, if this is an alarm based
    /// on a
    /// single metric.
    metric_name: ?[]const u8 = null,

    /// An array of MetricDataQuery structures, used in an alarm based on a metric
    /// math
    /// expression. Each structure either retrieves a metric or performs a math
    /// expression. One
    /// item in the Metrics array is the math expression that the alarm watches.
    /// This expression
    /// by designated by having `ReturnData` set to true.
    metrics: ?[]const MetricDataQuery = null,

    /// The namespace of the metric associated with the alarm.
    namespace: ?[]const u8 = null,

    /// The actions to execute when this alarm transitions to the `OK` state
    /// from any other state. Each action is specified as an Amazon Resource Name
    /// (ARN).
    ok_actions: ?[]const []const u8 = null,

    /// The period, in seconds, over which the statistic is applied.
    period: ?i32 = null,

    /// An explanation for the alarm state, in text format.
    state_reason: ?[]const u8 = null,

    /// An explanation for the alarm state, in JSON format.
    state_reason_data: ?[]const u8 = null,

    /// The date and time that the alarm's `StateValue` most recently
    /// changed.
    state_transitioned_timestamp: ?i64 = null,

    /// The time stamp of the last update to the value of either the
    /// `StateValue` or `EvaluationState` parameters.
    state_updated_timestamp: ?i64 = null,

    /// The state value for the alarm.
    state_value: ?StateValue = null,

    /// The statistic for the metric associated with the alarm, other than
    /// percentile. For
    /// percentile statistics, use `ExtendedStatistic`.
    statistic: ?Statistic = null,

    /// The value to compare with the specified statistic.
    threshold: ?f64 = null,

    /// In an alarm based on an anomaly detection model, this is the ID of the
    /// `ANOMALY_DETECTION_BAND` function used as the threshold for the
    /// alarm.
    threshold_metric_id: ?[]const u8 = null,

    /// Sets how this alarm is to handle missing data points. The valid values are
    /// `breaching`, `notBreaching`, `ignore`, and
    /// `missing`. For more information, see [Configuring how CloudWatch alarms
    /// treat missing
    /// data](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/AlarmThatSendsEmail.html#alarms-and-missing-data).
    ///
    /// If this parameter is omitted, the default behavior of `missing` is
    /// used.
    treat_missing_data: ?[]const u8 = null,

    /// The unit of the metric associated with the alarm.
    unit: ?StandardUnit = null,

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
        .evaluation_state = "EvaluationState",
        .extended_statistic = "ExtendedStatistic",
        .insufficient_data_actions = "InsufficientDataActions",
        .metric_name = "MetricName",
        .metrics = "Metrics",
        .namespace = "Namespace",
        .ok_actions = "OKActions",
        .period = "Period",
        .state_reason = "StateReason",
        .state_reason_data = "StateReasonData",
        .state_transitioned_timestamp = "StateTransitionedTimestamp",
        .state_updated_timestamp = "StateUpdatedTimestamp",
        .state_value = "StateValue",
        .statistic = "Statistic",
        .threshold = "Threshold",
        .threshold_metric_id = "ThresholdMetricId",
        .treat_missing_data = "TreatMissingData",
        .unit = "Unit",
    };
};
