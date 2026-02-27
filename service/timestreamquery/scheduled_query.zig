const ErrorReportConfiguration = @import("error_report_configuration.zig").ErrorReportConfiguration;
const ScheduledQueryRunStatus = @import("scheduled_query_run_status.zig").ScheduledQueryRunStatus;
const ScheduledQueryState = @import("scheduled_query_state.zig").ScheduledQueryState;
const TargetDestination = @import("target_destination.zig").TargetDestination;

/// Scheduled Query
pub const ScheduledQuery = struct {
    /// The Amazon Resource Name.
    arn: []const u8,

    /// The creation time of the scheduled query.
    creation_time: ?i64,

    /// Configuration for scheduled query error reporting.
    error_report_configuration: ?ErrorReportConfiguration,

    /// Status of the last scheduled query run.
    last_run_status: ?ScheduledQueryRunStatus,

    /// The name of the scheduled query.
    name: []const u8,

    /// The next time the scheduled query is to be run.
    next_invocation_time: ?i64,

    /// The last time the scheduled query was run.
    previous_invocation_time: ?i64,

    /// State of scheduled query.
    state: ScheduledQueryState,

    /// Target data source where final scheduled query result will be written.
    target_destination: ?TargetDestination,

    pub const json_field_names = .{
        .arn = "Arn",
        .creation_time = "CreationTime",
        .error_report_configuration = "ErrorReportConfiguration",
        .last_run_status = "LastRunStatus",
        .name = "Name",
        .next_invocation_time = "NextInvocationTime",
        .previous_invocation_time = "PreviousInvocationTime",
        .state = "State",
        .target_destination = "TargetDestination",
    };
};
