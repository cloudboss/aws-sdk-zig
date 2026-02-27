/// Represents a CloudWatch alarm associated with a scaling policy.
pub const Alarm = struct {
    /// The Amazon Resource Name (ARN) of the alarm.
    alarm_arn: []const u8,

    /// The name of the alarm.
    alarm_name: []const u8,

    pub const json_field_names = .{
        .alarm_arn = "AlarmARN",
        .alarm_name = "AlarmName",
    };
};
