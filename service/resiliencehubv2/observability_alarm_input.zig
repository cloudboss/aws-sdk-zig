/// Identifies an observability alarm by its ARN.
pub const ObservabilityAlarmInput = struct {
    /// The ARN of the CloudWatch alarm.
    alarm_arn: []const u8,

    pub const json_field_names = .{
        .alarm_arn = "alarmArn",
    };
};
