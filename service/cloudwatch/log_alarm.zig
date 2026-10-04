const ComparisonOperator = @import("comparison_operator.zig").ComparisonOperator;
const EvaluationState = @import("evaluation_state.zig").EvaluationState;
const ScheduledQueryConfiguration = @import("scheduled_query_configuration.zig").ScheduledQueryConfiguration;
const StateValue = @import("state_value.zig").StateValue;
const WarmUpConfiguration = @import("warm_up_configuration.zig").WarmUpConfiguration;

/// The details about a log alarm.
pub const LogAlarm = struct {
    /// The number of log lines from the most recent scheduled query execution that
    /// are included in alarm action notifications. Valid range is 0 through 50. A
    /// value of 0 means no log lines are included.
    action_log_line_count: ?i32 = null,

    /// The Amazon Resource Name (ARN) of the IAM role that CloudWatch assumes to
    /// retrieve log events for inclusion in alarm action notifications. Set when
    /// `ActionLogLineCount` is greater than 0.
    action_log_line_role_arn: ?[]const u8 = null,

    /// Indicates whether actions should be executed during any changes to the alarm
    /// state.
    actions_enabled: ?bool = null,

    /// The actions to execute when this alarm transitions to the `ALARM` state from
    /// any other state. Each action is specified as an Amazon Resource Name (ARN).
    alarm_actions: ?[]const []const u8 = null,

    /// The Amazon Resource Name (ARN) of the alarm.
    alarm_arn: ?[]const u8 = null,

    /// The time stamp of the last update to the alarm configuration.
    alarm_configuration_updated_timestamp: ?i64 = null,

    /// The description of the alarm.
    alarm_description: ?[]const u8 = null,

    /// The name of the alarm.
    alarm_name: ?[]const u8 = null,

    /// The arithmetic operation to use when comparing the aggregated query result
    /// and the threshold. The aggregated query result is used as the first operand.
    comparison_operator: ?ComparisonOperator = null,

    /// If the value of this field is `EVALUATION_ERROR`, it indicates configuration
    /// errors in the alarm setup that require review and correction. Refer to the
    /// `StateReason` field of the alarm for more details.
    ///
    /// If the value of this field is `EVALUATION_FAILURE`, it indicates temporary
    /// CloudWatch issues. We recommend manual monitoring until the issue is
    /// resolved.
    ///
    /// If the value of this field is `PARTIAL_DATA`, it indicates that the query
    /// returned the maximum 500 contributor groups but more matched. The alarm
    /// evaluates the available contributors, but results might be incomplete.
    evaluation_state: ?EvaluationState = null,

    /// The actions to execute when this alarm transitions to the
    /// `INSUFFICIENT_DATA` state from any other state. Each action is specified as
    /// an Amazon Resource Name (ARN).
    insufficient_data_actions: ?[]const []const u8 = null,

    /// The actions to execute when this alarm transitions to the `OK` state from
    /// any other state. Each action is specified as an Amazon Resource Name (ARN).
    ok_actions: ?[]const []const u8 = null,

    /// The number of query results, out of the most recent `QueryResultsToEvaluate`
    /// results, that must breach the threshold to trigger the alarm to transition
    /// to `ALARM` (the M in M-of-N evaluation).
    query_results_to_alarm: ?i32 = null,

    /// The number of most recent scheduled query results that the alarm evaluates
    /// against the threshold (the N in M-of-N evaluation).
    query_results_to_evaluate: ?i32 = null,

    /// The configuration of the underlying CloudWatch Logs scheduled query,
    /// including the query string, log groups, schedule, aggregation expression,
    /// and the ARN of the managed scheduled query.
    scheduled_query_configuration: ?ScheduledQueryConfiguration = null,

    /// An explanation for the alarm state, in text format.
    state_reason: ?[]const u8 = null,

    /// An explanation for the alarm state, in JSON format.
    state_reason_data: ?[]const u8 = null,

    /// The date and time that the alarm's `StateValue` most recently changed.
    state_transitioned_timestamp: ?i64 = null,

    /// The time stamp of the last update to the value of either the `StateValue` or
    /// `EvaluationState` parameters.
    state_updated_timestamp: ?i64 = null,

    /// The state value for the alarm.
    state_value: ?StateValue = null,

    /// The value to compare with the aggregated query result.
    threshold: ?f64 = null,

    /// How this alarm handles missing data points. Valid values are `breaching`,
    /// `notBreaching`, `ignore`, and `missing`.
    treat_missing_data: ?[]const u8 = null,

    /// The warm-up configuration for the alarm. A warm-up period delays alarm
    /// evaluation
    /// after you create or update the alarm. During the warm-up period, the alarm
    /// stays in
    /// `INSUFFICIENT_DATA` and does not perform alarm actions.
    ///
    /// For more information, see [Alarm warm-up
    /// periods](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/alarm-warm-up.html) in the *Amazon CloudWatch User Guide*.
    warm_up_configuration: ?WarmUpConfiguration = null,

    pub const json_field_names = .{
        .action_log_line_count = "ActionLogLineCount",
        .action_log_line_role_arn = "ActionLogLineRoleArn",
        .actions_enabled = "ActionsEnabled",
        .alarm_actions = "AlarmActions",
        .alarm_arn = "AlarmArn",
        .alarm_configuration_updated_timestamp = "AlarmConfigurationUpdatedTimestamp",
        .alarm_description = "AlarmDescription",
        .alarm_name = "AlarmName",
        .comparison_operator = "ComparisonOperator",
        .evaluation_state = "EvaluationState",
        .insufficient_data_actions = "InsufficientDataActions",
        .ok_actions = "OKActions",
        .query_results_to_alarm = "QueryResultsToAlarm",
        .query_results_to_evaluate = "QueryResultsToEvaluate",
        .scheduled_query_configuration = "ScheduledQueryConfiguration",
        .state_reason = "StateReason",
        .state_reason_data = "StateReasonData",
        .state_transitioned_timestamp = "StateTransitionedTimestamp",
        .state_updated_timestamp = "StateUpdatedTimestamp",
        .state_value = "StateValue",
        .threshold = "Threshold",
        .treat_missing_data = "TreatMissingData",
        .warm_up_configuration = "WarmUpConfiguration",
    };
};
