/// Contains the configuration information of a snooze action.
pub const SnoozeActionConfiguration = struct {
    /// The note that you can leave when you snooze the alarm.
    note: ?[]const u8 = null,

    /// The snooze time in seconds. The alarm automatically changes to the `NORMAL`
    /// state after this duration.
    snooze_duration: ?i32 = null,

    pub const json_field_names = .{
        .note = "note",
        .snooze_duration = "snoozeDuration",
    };
};
