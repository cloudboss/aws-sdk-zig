const Schedule = @import("schedule.zig").Schedule;
const State = @import("state.zig").State;
const TargetAction = @import("target_action.zig").TargetAction;

/// The returned scheduled action object.
pub const ScheduledActionResponse = struct {
    /// The end time of
    end_time: ?i64,

    /// The end time in UTC when the schedule is no longer active. After this time,
    /// the scheduled action does not trigger.
    namespace_name: ?[]const u8,

    /// An array of timestamps of when the next scheduled actions will trigger.
    next_invocations: ?[]const i64,

    /// The ARN of the IAM role to assume to run the scheduled action. This IAM role
    /// must have permission to run the Amazon Redshift Serverless API operation in
    /// the scheduled action. This IAM role must allow the Amazon Redshift scheduler
    /// to schedule creating snapshots. (Principal scheduler.redshift.amazonaws.com)
    /// to assume permissions on your behalf. For more information about the IAM
    /// role to use with the Amazon Redshift scheduler, see [Using Identity-Based
    /// Policies for Amazon
    /// Redshift](https://docs.aws.amazon.com/redshift/latest/mgmt/redshift-iam-access-control-identity-based.html) in the Amazon Redshift Management Guide
    role_arn: ?[]const u8,

    /// The schedule for a one-time (at timestamp format) or recurring (cron format)
    /// scheduled action. Schedule invocations must be separated by at least one
    /// hour. Times are in UTC.
    ///
    /// * Format of at timestamp is `yyyy-mm-ddThh:mm:ss`. For example,
    ///   `2016-03-04T17:27:00`.
    /// * Format of cron expression is `(Minutes Hours Day-of-month Month
    ///   Day-of-week Year)`. For example, `"(0 10 ? * MON *)"`. For more
    ///   information, see [Cron
    ///   Expressions](https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/ScheduledEvents.html#CronExpressions) in the *Amazon CloudWatch Events User Guide*.
    schedule: ?Schedule,

    /// The description of the scheduled action.
    scheduled_action_description: ?[]const u8,

    /// The name of the scheduled action.
    scheduled_action_name: ?[]const u8,

    /// The uuid of the scheduled action.
    scheduled_action_uuid: ?[]const u8,

    /// The start time in UTC when the schedule is active. Before this time, the
    /// scheduled action does not trigger.
    start_time: ?i64,

    /// The state of the scheduled action.
    state: ?State,

    target_action: ?TargetAction,

    pub const json_field_names = .{
        .end_time = "endTime",
        .namespace_name = "namespaceName",
        .next_invocations = "nextInvocations",
        .role_arn = "roleArn",
        .schedule = "schedule",
        .scheduled_action_description = "scheduledActionDescription",
        .scheduled_action_name = "scheduledActionName",
        .scheduled_action_uuid = "scheduledActionUuid",
        .start_time = "startTime",
        .state = "state",
        .target_action = "targetAction",
    };
};
