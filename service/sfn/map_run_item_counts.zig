/// Contains details about items that were processed in all of the child
/// workflow executions that were started by a Map Run.
pub const MapRunItemCounts = struct {
    /// The total number of items processed in child workflow executions that were
    /// either stopped by the user or by Step Functions, because the Map Run failed.
    aborted: i64 = 0,

    /// The total number of items processed in child workflow executions that have
    /// failed.
    failed: i64 = 0,

    /// The number of `FAILED`, `ABORTED`, or `TIMED_OUT` items in child workflow
    /// executions that cannot be redriven because the execution status of those
    /// child workflows is terminal. For example, child workflows with an execution
    /// status of `FAILED`, `ABORTED`, or `TIMED_OUT` and a `redriveStatus` of
    /// `NOT_REDRIVABLE`.
    failures_not_redrivable: ?i64,

    /// The total number of items to process in child workflow executions that
    /// haven't started running yet.
    pending: i64 = 0,

    /// The number of unsuccessful items in child workflow executions currently
    /// waiting to be redriven.
    pending_redrive: ?i64,

    /// Returns the count of items whose results were written by `ResultWriter`. For
    /// more information, see
    /// [ResultWriter](https://docs.aws.amazon.com/step-functions/latest/dg/input-output-resultwriter.html) in the *Step Functions Developer Guide*.
    results_written: i64 = 0,

    /// The total number of items being processed in child workflow executions that
    /// are currently in-progress.
    running: i64 = 0,

    /// The total number of items processed in child workflow executions that have
    /// completed successfully.
    succeeded: i64 = 0,

    /// The total number of items processed in child workflow executions that have
    /// timed out.
    timed_out: i64 = 0,

    /// The total number of items processed in all the child workflow executions
    /// started by a Map Run.
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
