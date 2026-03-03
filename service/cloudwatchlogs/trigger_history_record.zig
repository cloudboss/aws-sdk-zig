const ScheduledQueryDestination = @import("scheduled_query_destination.zig").ScheduledQueryDestination;
const ExecutionStatus = @import("execution_status.zig").ExecutionStatus;

/// A record of a scheduled query execution, including execution status,
/// timestamp, and
/// destination processing results.
pub const TriggerHistoryRecord = struct {
    /// Information about destination processing for this query execution.
    destinations: ?[]const ScheduledQueryDestination = null,

    /// Error message if the query execution failed.
    error_message: ?[]const u8 = null,

    /// The execution status of the scheduled query run.
    execution_status: ?ExecutionStatus = null,

    /// The unique identifier for this query execution.
    query_id: ?[]const u8 = null,

    /// The timestamp when the scheduled query execution was triggered.
    triggered_timestamp: ?i64 = null,

    pub const json_field_names = .{
        .destinations = "destinations",
        .error_message = "errorMessage",
        .execution_status = "executionStatus",
        .query_id = "queryId",
        .triggered_timestamp = "triggeredTimestamp",
    };
};
