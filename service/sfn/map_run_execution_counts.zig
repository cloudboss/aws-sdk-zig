/// Contains details about all of the child workflow executions started by a Map
/// Run.
pub const MapRunExecutionCounts = struct {
    /// The total number of child workflow executions that were started by a Map Run
    /// and were running, but were either stopped by the user or by Step Functions
    /// because the Map Run failed.
    aborted: i64 = 0,

    /// The total number of child workflow executions that were started by a Map
    /// Run, but have failed.
    failed: i64 = 0,

    /// The number of `FAILED`, `ABORTED`, or `TIMED_OUT` child workflow executions
    /// that cannot be redriven because their execution status is terminal. For
    /// example, child workflows with an execution status of `FAILED`, `ABORTED`, or
    /// `TIMED_OUT` and a `redriveStatus` of `NOT_REDRIVABLE`.
    failures_not_redrivable: ?i64 = null,

    /// The total number of child workflow executions that were started by a Map
    /// Run, but haven't started executing yet.
    pending: i64 = 0,

    /// The number of unsuccessful child workflow executions currently waiting to be
    /// redriven. The status of these child workflow executions could be `FAILED`,
    /// `ABORTED`, or `TIMED_OUT` in the original execution attempt or a previous
    /// redrive attempt.
    pending_redrive: ?i64 = null,

    /// Returns the count of child workflow executions whose results were written by
    /// `ResultWriter`. For more information, see
    /// [ResultWriter](https://docs.aws.amazon.com/step-functions/latest/dg/input-output-resultwriter.html) in the *Step Functions Developer Guide*.
    results_written: i64 = 0,

    /// The total number of child workflow executions that were started by a Map Run
    /// and are currently in-progress.
    running: i64 = 0,

    /// The total number of child workflow executions that were started by a Map Run
    /// and have completed successfully.
    succeeded: i64 = 0,

    /// The total number of child workflow executions that were started by a Map Run
    /// and have timed out.
    timed_out: i64 = 0,

    /// The total number of child workflow executions that were started by a Map
    /// Run.
    total: i64 = 0,

    pub const json_field_names = .{
        .aborted = "aborted",
        .failed = "failed",
        .failures_not_redrivable = "failuresNotRedrivable",
        .pending = "pending",
        .pending_redrive = "pendingRedrive",
        .results_written = "resultsWritten",
        .running = "running",
        .succeeded = "succeeded",
        .timed_out = "timedOut",
        .total = "total",
    };
};
