/// Describes an action that updates a CloudWatch alarm.
pub const CloudwatchAlarmAction = struct {
    /// The CloudWatch alarm name.
    alarm_name: []const u8,

    /// The IAM role that allows access to the CloudWatch alarm.
    role_arn: []const u8,

    /// The reason for the alarm change.
    state_reason: []const u8,

    /// The value of the alarm state. Acceptable values are: OK, ALARM,
    /// INSUFFICIENT_DATA.
    state_value: []const u8,

    pub const json_field_names = .{
        .alarm_name = "alarmName",
        .role_arn = "roleArn",
        .state_reason = "stateReason",
        .state_value = "stateValue",
    };
};
