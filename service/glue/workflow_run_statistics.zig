/// Workflow run statistics provides statistics about the workflow run.
pub const WorkflowRunStatistics = struct {
    /// Indicates the count of job runs in the ERROR state in the workflow run.
    errored_actions: i32 = 0,

    /// Total number of Actions that have failed.
    failed_actions: i32 = 0,

    /// Total number Actions in running state.
    running_actions: i32 = 0,

    /// Total number of Actions that have stopped.
    stopped_actions: i32 = 0,

    /// Total number of Actions that have succeeded.
    succeeded_actions: i32 = 0,

    /// Total number of Actions that timed out.
    timeout_actions: i32 = 0,

    /// Total number of Actions in the workflow run.
    total_actions: i32 = 0,

    /// Indicates the count of job runs in WAITING state in the workflow run.
    waiting_actions: i32 = 0,

    pub const json_field_names = .{
        .errored_actions = "ErroredActions",
        .failed_actions = "FailedActions",
        .running_actions = "RunningActions",
        .stopped_actions = "StoppedActions",
        .succeeded_actions = "SucceededActions",
        .timeout_actions = "TimeoutActions",
        .total_actions = "TotalActions",
        .waiting_actions = "WaitingActions",
    };
};
