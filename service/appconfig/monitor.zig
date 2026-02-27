/// Amazon CloudWatch alarms to monitor during the deployment process.
pub const Monitor = struct {
    /// Amazon Resource Name (ARN) of the Amazon CloudWatch alarm.
    alarm_arn: []const u8,

    /// ARN of an Identity and Access Management (IAM) role for AppConfig to monitor
    /// `AlarmArn`.
    alarm_role_arn: ?[]const u8,

    pub const json_field_names = .{
        .alarm_arn = "AlarmArn",
        .alarm_role_arn = "AlarmRoleArn",
    };
};
