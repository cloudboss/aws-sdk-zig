const ActionsSuppressedBy = @import("actions_suppressed_by.zig").ActionsSuppressedBy;
const StateValue = @import("state_value.zig").StateValue;

/// The details about a composite alarm.
pub const CompositeAlarm = struct {
    /// Indicates whether actions should be executed during any changes to the alarm
    /// state.
    actions_enabled: ?bool = null,

    /// When the value is `ALARM`, it means that the actions are suppressed
    /// because the suppressor alarm is in `ALARM` When the value is
    /// `WaitPeriod`, it means that the actions are suppressed because the
    /// composite alarm is waiting for the suppressor alarm to go into into the
    /// `ALARM` state. The maximum waiting time is as specified in
    /// `ActionsSuppressorWaitPeriod`. After this time, the composite alarm
    /// performs its actions. When the value is `ExtensionPeriod`, it means that the
    /// actions are suppressed because the composite alarm is waiting after the
    /// suppressor alarm
    /// went out of the `ALARM` state. The maximum waiting time is as specified in
    /// `ActionsSuppressorExtensionPeriod`. After this time, the composite alarm
    /// performs its actions.
    actions_suppressed_by: ?ActionsSuppressedBy = null,

    /// Captures the reason for action suppression.
    actions_suppressed_reason: ?[]const u8 = null,

    /// Actions will be suppressed if the suppressor alarm is in the `ALARM`
    /// state. `ActionsSuppressor` can be an AlarmName or an Amazon Resource Name
    /// (ARN) from an existing alarm.
    actions_suppressor: ?[]const u8 = null,

    /// The maximum time in seconds that the composite alarm waits after suppressor
    /// alarm
    /// goes out of the `ALARM` state. After this time, the composite alarm performs
    /// its actions.
    ///
    /// `ExtensionPeriod` is required only when `ActionsSuppressor` is
    /// specified.
    actions_suppressor_extension_period: ?i32 = null,

    /// The maximum time in seconds that the composite alarm waits for the
    /// suppressor alarm
    /// to go into the `ALARM` state. After this time, the composite alarm performs
    /// its actions.
    ///
    /// `WaitPeriod` is required only when `ActionsSuppressor` is
    /// specified.
    actions_suppressor_wait_period: ?i32 = null,

    /// The actions to execute when this alarm transitions to the ALARM state from
    /// any other
    /// state. Each action is specified as an Amazon Resource Name (ARN).
    alarm_actions: ?[]const []const u8 = null,

    /// The Amazon Resource Name (ARN) of the alarm.
    alarm_arn: ?[]const u8 = null,

    /// The time stamp of the last update to the alarm configuration.
    alarm_configuration_updated_timestamp: ?i64 = null,

    /// The description of the alarm.
    alarm_description: ?[]const u8 = null,

    /// The name of the alarm.
    alarm_name: ?[]const u8 = null,

    /// The rule that this alarm uses to evaluate its alarm state.
    alarm_rule: ?[]const u8 = null,

    /// The actions to execute when this alarm transitions to the INSUFFICIENT_DATA
    /// state from
    /// any other state. Each action is specified as an Amazon Resource Name (ARN).
    insufficient_data_actions: ?[]const []const u8 = null,

    /// The actions to execute when this alarm transitions to the OK state from any
    /// other
    /// state. Each action is specified as an Amazon Resource Name (ARN).
    ok_actions: ?[]const []const u8 = null,

    /// An explanation for the alarm state, in text format.
    state_reason: ?[]const u8 = null,

    /// An explanation for the alarm state, in JSON format.
    state_reason_data: ?[]const u8 = null,

    /// The timestamp of the last change to the alarm's `StateValue`.
    state_transitioned_timestamp: ?i64 = null,

    /// Tracks the timestamp of any state update, even if `StateValue` doesn't
    /// change.
    state_updated_timestamp: ?i64 = null,

    /// The state value for the alarm.
    state_value: ?StateValue = null,

    pub const json_field_names = .{
        .actions_enabled = "ActionsEnabled",
        .actions_suppressed_by = "ActionsSuppressedBy",
        .actions_suppressed_reason = "ActionsSuppressedReason",
        .actions_suppressor = "ActionsSuppressor",
        .actions_suppressor_extension_period = "ActionsSuppressorExtensionPeriod",
        .actions_suppressor_wait_period = "ActionsSuppressorWaitPeriod",
        .alarm_actions = "AlarmActions",
        .alarm_arn = "AlarmArn",
        .alarm_configuration_updated_timestamp = "AlarmConfigurationUpdatedTimestamp",
        .alarm_description = "AlarmDescription",
        .alarm_name = "AlarmName",
        .alarm_rule = "AlarmRule",
        .insufficient_data_actions = "InsufficientDataActions",
        .ok_actions = "OKActions",
        .state_reason = "StateReason",
        .state_reason_data = "StateReasonData",
        .state_transitioned_timestamp = "StateTransitionedTimestamp",
        .state_updated_timestamp = "StateUpdatedTimestamp",
        .state_value = "StateValue",
    };
};
