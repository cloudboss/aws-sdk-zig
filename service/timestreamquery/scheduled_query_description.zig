const ErrorReportConfiguration = @import("error_report_configuration.zig").ErrorReportConfiguration;
const ScheduledQueryRunSummary = @import("scheduled_query_run_summary.zig").ScheduledQueryRunSummary;
const NotificationConfiguration = @import("notification_configuration.zig").NotificationConfiguration;
const ScheduleConfiguration = @import("schedule_configuration.zig").ScheduleConfiguration;
const ScheduledQueryState = @import("scheduled_query_state.zig").ScheduledQueryState;
const TargetConfiguration = @import("target_configuration.zig").TargetConfiguration;

/// Structure that describes scheduled query.
pub const ScheduledQueryDescription = struct {
    /// Scheduled query ARN.
    arn: []const u8,

    /// Creation time of the scheduled query.
    creation_time: ?i64 = null,

    /// Error-reporting configuration for the scheduled query.
    error_report_configuration: ?ErrorReportConfiguration = null,

    /// A customer provided KMS key used to encrypt the scheduled query resource.
    kms_key_id: ?[]const u8 = null,

    /// Runtime summary for the last scheduled query run.
    last_run_summary: ?ScheduledQueryRunSummary = null,

    /// Name of the scheduled query.
    name: []const u8,

    /// The next time the scheduled query is scheduled to run.
    next_invocation_time: ?i64 = null,

    /// Notification configuration.
    notification_configuration: NotificationConfiguration,

    /// Last time the query was run.
    previous_invocation_time: ?i64 = null,

    /// The query to be run.
    query_string: []const u8,

    /// Runtime summary for the last five failed scheduled query runs.
    recently_failed_runs: ?[]const ScheduledQueryRunSummary = null,

    /// Schedule configuration.
    schedule_configuration: ScheduleConfiguration,

    /// IAM role that Timestream uses to run the schedule query.
    scheduled_query_execution_role_arn: ?[]const u8 = null,

    /// State of the scheduled query.
    state: ScheduledQueryState,

    /// Scheduled query target store configuration.
    target_configuration: ?TargetConfiguration = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .creation_time = "CreationTime",
        .error_report_configuration = "ErrorReportConfiguration",
        .kms_key_id = "KmsKeyId",
        .last_run_summary = "LastRunSummary",
        .name = "Name",
        .next_invocation_time = "NextInvocationTime",
        .notification_configuration = "NotificationConfiguration",
        .previous_invocation_time = "PreviousInvocationTime",
        .query_string = "QueryString",
        .recently_failed_runs = "RecentlyFailedRuns",
        .schedule_configuration = "ScheduleConfiguration",
        .scheduled_query_execution_role_arn = "ScheduledQueryExecutionRoleArn",
        .state = "State",
        .target_configuration = "TargetConfiguration",
    };
};
