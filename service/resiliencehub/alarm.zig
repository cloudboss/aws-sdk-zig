/// Indicates the Amazon CloudWatch alarm detected while running an assessment.
pub const Alarm = struct {
    /// Amazon Resource Name (ARN) of the Amazon CloudWatch alarm.
    alarm_arn: ?[]const u8 = null,

    /// Indicates the source of the Amazon CloudWatch alarm. That is, it indicates
    /// if the
    /// alarm was created using Resilience Hub recommendation (`AwsResilienceHub`),
    /// or if you had created the alarm in Amazon CloudWatch (`Customer`).
    source: ?[]const u8 = null,

    pub const json_field_names = .{
        .alarm_arn = "alarmArn",
        .source = "source",
    };
};
