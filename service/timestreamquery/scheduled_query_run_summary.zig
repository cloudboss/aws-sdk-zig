const ErrorReportLocation = @import("error_report_location.zig").ErrorReportLocation;
const ExecutionStats = @import("execution_stats.zig").ExecutionStats;
const ScheduledQueryInsightsResponse = @import("scheduled_query_insights_response.zig").ScheduledQueryInsightsResponse;
const ScheduledQueryRunStatus = @import("scheduled_query_run_status.zig").ScheduledQueryRunStatus;

/// Run summary for the scheduled query
pub const ScheduledQueryRunSummary = struct {
    /// S3 location for error report.
    error_report_location: ?ErrorReportLocation = null,

    /// Runtime statistics for a scheduled run.
    execution_stats: ?ExecutionStats = null,

    /// Error message for the scheduled query in case of failure. You might have to
    /// look at
    /// the error report to get more detailed error reasons.
    failure_reason: ?[]const u8 = null,

    /// InvocationTime for this run. This is the time at which the query is
    /// scheduled to run.
    /// Parameter `@scheduled_runtime` can be used in the query to get the value.
    invocation_time: ?i64 = null,

    /// Provides various insights and metrics related to the run summary of the
    /// scheduled query.
    query_insights_response: ?ScheduledQueryInsightsResponse = null,

    /// The status of a scheduled query run.
    run_status: ?ScheduledQueryRunStatus = null,

    /// The actual time when the query was run.
    trigger_time: ?i64 = null,

    pub const json_field_names = .{
        .error_report_location = "ErrorReportLocation",
        .execution_stats = "ExecutionStats",
        .failure_reason = "FailureReason",
        .invocation_time = "InvocationTime",
        .query_insights_response = "QueryInsightsResponse",
        .run_status = "RunStatus",
        .trigger_time = "TriggerTime",
    };
};
