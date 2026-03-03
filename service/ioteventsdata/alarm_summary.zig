const AlarmStateName = @import("alarm_state_name.zig").AlarmStateName;

/// Contains a summary of an alarm.
pub const AlarmSummary = struct {
    /// The name of the alarm model.
    alarm_model_name: ?[]const u8 = null,

    /// The version of the alarm model.
    alarm_model_version: ?[]const u8 = null,

    /// The time the alarm was created, in the Unix epoch format.
    creation_time: ?i64 = null,

    /// The value of the key used as a filter to select only the alarms associated
    /// with the
    /// [key](https://docs.aws.amazon.com/iotevents/latest/apireference/API_CreateAlarmModel.html#iotevents-CreateAlarmModel-request-key).
    key_value: ?[]const u8 = null,

    /// The time the alarm was last updated, in the Unix epoch format.
    last_update_time: ?i64 = null,

    /// The name of the alarm state. The state name can be one of the following
    /// values:
    ///
    /// * `DISABLED` - When the alarm is in the `DISABLED` state,
    /// it isn't ready to evaluate data. To enable the alarm,
    /// you must change the alarm to the `NORMAL` state.
    ///
    /// * `NORMAL` - When the alarm is in the `NORMAL` state,
    /// it's ready to evaluate data.
    ///
    /// * `ACTIVE` - If the alarm is in the `ACTIVE` state,
    /// the alarm is invoked.
    ///
    /// * `ACKNOWLEDGED` - When the alarm is in the `ACKNOWLEDGED` state,
    /// the alarm was invoked and you acknowledged the alarm.
    ///
    /// * `SNOOZE_DISABLED` - When the alarm is in the `SNOOZE_DISABLED` state,
    /// the alarm is disabled for a specified period of time. After the snooze time,
    /// the alarm automatically changes to the `NORMAL` state.
    ///
    /// * `LATCHED` - When the alarm is in the `LATCHED` state,
    /// the alarm was invoked. However, the data that the alarm is currently
    /// evaluating is within the specified range.
    /// To change the alarm to the `NORMAL` state, you must acknowledge the alarm.
    state_name: ?AlarmStateName = null,

    pub const json_field_names = .{
        .alarm_model_name = "alarmModelName",
        .alarm_model_version = "alarmModelVersion",
        .creation_time = "creationTime",
        .key_value = "keyValue",
        .last_update_time = "lastUpdateTime",
        .state_name = "stateName",
    };
};
