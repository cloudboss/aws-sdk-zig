/// Information needed to reset the alarm.
pub const ResetAlarmActionRequest = struct {
    /// The name of the alarm model.
    alarm_model_name: []const u8,

    /// The value of the key used as a filter to select only the alarms associated
    /// with the
    /// [key](https://docs.aws.amazon.com/iotevents/latest/apireference/API_CreateAlarmModel.html#iotevents-CreateAlarmModel-request-key).
    key_value: ?[]const u8 = null,

    /// The note that you can leave when you reset the alarm.
    note: ?[]const u8 = null,

    /// The request ID. Each ID must be unique within each batch.
    request_id: []const u8,

    pub const json_field_names = .{
        .alarm_model_name = "alarmModelName",
        .key_value = "keyValue",
        .note = "note",
        .request_id = "requestId",
    };
};
