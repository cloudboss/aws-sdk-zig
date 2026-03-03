/// Contains a summary of an alarm model.
pub const AlarmModelSummary = struct {
    /// The description of the alarm model.
    alarm_model_description: ?[]const u8 = null,

    /// The name of the alarm model.
    alarm_model_name: ?[]const u8 = null,

    /// The time the alarm model was created, in the Unix epoch format.
    creation_time: ?i64 = null,

    pub const json_field_names = .{
        .alarm_model_description = "alarmModelDescription",
        .alarm_model_name = "alarmModelName",
        .creation_time = "creationTime",
    };
};
