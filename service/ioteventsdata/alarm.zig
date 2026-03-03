const AlarmState = @import("alarm_state.zig").AlarmState;

/// Contains information about an alarm.
pub const Alarm = struct {
    /// The name of the alarm model.
    alarm_model_name: ?[]const u8 = null,

    /// The version of the alarm model.
    alarm_model_version: ?[]const u8 = null,

    /// Contains information about the current state of the alarm.
    alarm_state: ?AlarmState = null,

    /// The time the alarm was created, in the Unix epoch format.
    creation_time: ?i64 = null,

    /// The value of the key used as a filter to select only the alarms associated
    /// with the
    /// [key](https://docs.aws.amazon.com/iotevents/latest/apireference/API_CreateAlarmModel.html#iotevents-CreateAlarmModel-request-key).
    key_value: ?[]const u8 = null,

    /// The time the alarm was last updated, in the Unix epoch format.
    last_update_time: ?i64 = null,

    /// A non-negative integer that reflects the severity level of the alarm.
    severity: ?i32 = null,

    pub const json_field_names = .{
        .alarm_model_name = "alarmModelName",
        .alarm_model_version = "alarmModelVersion",
        .alarm_state = "alarmState",
        .creation_time = "creationTime",
        .key_value = "keyValue",
        .last_update_time = "lastUpdateTime",
        .severity = "severity",
    };
};
