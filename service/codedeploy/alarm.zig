/// Information about an alarm.
pub const Alarm = struct {
    /// The name of the alarm. Maximum length is 255 characters. Each alarm name can
    /// be used
    /// only once in a list of alarms.
    name: ?[]const u8,

    pub const json_field_names = .{
        .name = "name",
    };
};
