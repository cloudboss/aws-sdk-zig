/// Summary information about an observability alarm snapshot captured for a
/// test run.
pub const TestRunObservabilityAlarmSummary = struct {
    /// The account ID that owns the CloudWatch alarm.
    account_id: []const u8,

    /// The ARN of the CloudWatch alarm.
    alarm_arn: []const u8,

    /// The name of the CloudWatch alarm.
    alarm_name: []const u8,

    /// The Region of the CloudWatch alarm.
    region: []const u8,

    pub const json_field_names = .{
        .account_id = "accountId",
        .alarm_arn = "alarmArn",
        .alarm_name = "alarmName",
        .region = "region",
    };
};
