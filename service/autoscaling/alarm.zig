/// Describes an alarm.
pub const Alarm = struct {
    /// The Amazon Resource Name (ARN) of the alarm.
    alarm_arn: ?[]const u8 = null,

    /// The name of the alarm.
    alarm_name: ?[]const u8 = null,
};
