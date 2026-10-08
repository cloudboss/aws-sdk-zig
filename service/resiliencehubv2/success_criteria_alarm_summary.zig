/// Summary information about a configured success criteria alarm.
pub const SuccessCriteriaAlarmSummary = struct {
    /// The account ID that owns the CloudWatch alarm.
    account_id: []const u8,

    /// The ARN of the CloudWatch alarm.
    alarm_arn: []const u8,

    /// The name of the CloudWatch alarm.
    alarm_name: []const u8,

    /// The timestamp when the source was configured.
    created_at: ?i64 = null,

    /// The Region of the CloudWatch alarm.
    region: []const u8,

    pub const json_field_names = .{
        .account_id = "accountId",
        .alarm_arn = "alarmArn",
        .alarm_name = "alarmName",
        .created_at = "createdAt",
        .region = "region",
    };
};
