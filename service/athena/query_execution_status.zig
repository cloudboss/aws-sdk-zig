const AthenaError = @import("athena_error.zig").AthenaError;
const QueryExecutionState = @import("query_execution_state.zig").QueryExecutionState;

/// The completion date, current state, submission time, and state change reason
/// (if
/// applicable) for the query execution.
pub const QueryExecutionStatus = struct {
    /// Provides information about an Athena query error.
    athena_error: ?AthenaError = null,

    /// The date and time that the query completed.
    completion_date_time: ?i64 = null,

    /// The state of query execution. `QUEUED` indicates that the query has been
    /// submitted to the service, and Athena will execute the query as soon as
    /// resources are available. `RUNNING` indicates that the query is in execution
    /// phase. `SUCCEEDED` indicates that the query completed without errors.
    /// `FAILED` indicates that the query experienced an error and did not
    /// complete processing. `CANCELLED` indicates that a user input interrupted
    /// query execution.
    ///
    /// For queries that experience certain transient errors, the state transitions
    /// from
    /// `RUNNING` back to `QUEUED`. The `FAILED` state
    /// is always terminal with no automatic retry.
    state: ?QueryExecutionState = null,

    /// Further detail about the status of the query.
    state_change_reason: ?[]const u8 = null,

    /// The date and time that the query was submitted.
    submission_date_time: ?i64 = null,

    pub const json_field_names = .{
        .athena_error = "AthenaError",
        .completion_date_time = "CompletionDateTime",
        .state = "State",
        .state_change_reason = "StateChangeReason",
        .submission_date_time = "SubmissionDateTime",
    };
};
