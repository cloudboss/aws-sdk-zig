const TestSourceOutcome = @import("test_source_outcome.zig").TestSourceOutcome;

/// Summary information about a success criteria alarm snapshot captured for a
/// test run.
pub const TestRunSuccessCriteriaAlarmSummary = struct {
    /// The account ID that owns the CloudWatch alarm.
    account_id: []const u8,

    /// The ARN of the CloudWatch alarm.
    alarm_arn: []const u8,

    /// The name of the CloudWatch alarm.
    alarm_name: []const u8,

    /// The evaluation outcome of the source. Absent while the source has not yet
    /// been evaluated; set to the terminal outcome afterwards.
    outcome: ?TestSourceOutcome = null,

    /// A human-readable reason for the outcome.
    outcome_reason: ?[]const u8 = null,

    /// The Region of the CloudWatch alarm.
    region: []const u8,

    pub const json_field_names = .{
        .account_id = "accountId",
        .alarm_arn = "alarmArn",
        .alarm_name = "alarmName",
        .outcome = "outcome",
        .outcome_reason = "outcomeReason",
        .region = "region",
    };
};
