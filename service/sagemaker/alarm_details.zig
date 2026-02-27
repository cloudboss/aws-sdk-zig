/// The details of the alarm to monitor during the AMI update.
pub const AlarmDetails = struct {
    /// The name of the alarm.
    alarm_name: []const u8,

    pub const json_field_names = .{
        .alarm_name = "AlarmName",
    };
};
