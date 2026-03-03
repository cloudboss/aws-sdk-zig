const ScheduledActionState = @import("scheduled_action_state.zig").ScheduledActionState;
const ScheduledActionType = @import("scheduled_action_type.zig").ScheduledActionType;

/// Describes a scheduled action. You can use a scheduled action to trigger some
/// Amazon Redshift API operations on a schedule.
/// For information about which API operations can be scheduled, see
/// ScheduledActionType.
pub const ScheduledAction = struct {
    /// The end time in UTC when the schedule is no longer active. After this time,
    /// the scheduled action does not trigger.
    end_time: ?i64 = null,

    /// The IAM role to assume to run the scheduled action.
    /// This IAM role must have permission to run the Amazon Redshift API operation
    /// in the scheduled action.
    /// This IAM role must allow the Amazon Redshift scheduler (Principal
    /// scheduler.redshift.amazonaws.com) to assume permissions on your behalf.
    ///
    /// For more information about the IAM role to use with the Amazon Redshift
    /// scheduler, see
    /// [Using Identity-Based Policies for Amazon
    /// Redshift](https://docs.aws.amazon.com/redshift/latest/mgmt/redshift-iam-access-control-identity-based.html)
    /// in the *Amazon Redshift Cluster Management Guide*.
    iam_role: ?[]const u8 = null,

    /// List of times when the scheduled action will run.
    next_invocations: ?[]const i64 = null,

    /// The schedule for a one-time (at format) or recurring (cron format) scheduled
    /// action.
    /// Schedule invocations must be separated by at least one hour.
    ///
    /// Format of at expressions is "`at(yyyy-mm-ddThh:mm:ss)`". For example,
    /// "`at(2016-03-04T17:27:00)`".
    ///
    /// Format of cron expressions is "`cron(Minutes Hours Day-of-month Month
    /// Day-of-week Year)`".
    /// For example, "`cron(0 10 ? * MON *)`". For more information, see
    /// [Cron
    /// Expressions](https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/ScheduledEvents.html#CronExpressions)
    /// in the *Amazon CloudWatch Events User Guide*.
    schedule: ?[]const u8 = null,

    /// The description of the scheduled action.
    scheduled_action_description: ?[]const u8 = null,

    /// The name of the scheduled action.
    scheduled_action_name: ?[]const u8 = null,

    /// The start time in UTC when the schedule is active. Before this time, the
    /// scheduled action does not trigger.
    start_time: ?i64 = null,

    /// The state of the scheduled action. For example, `DISABLED`.
    state: ?ScheduledActionState = null,

    /// A JSON format string of the Amazon Redshift API operation with input
    /// parameters.
    ///
    /// "`{\"ResizeCluster\":{\"NodeType\":\"ra3.4xlarge\",\"ClusterIdentifier\":\"my-test-cluster\",\"NumberOfNodes\":3}}`".
    target_action: ?ScheduledActionType = null,
};
