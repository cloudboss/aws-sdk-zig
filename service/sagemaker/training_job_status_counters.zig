/// The numbers of training jobs launched by a hyperparameter tuning job,
/// categorized by status.
pub const TrainingJobStatusCounters = struct {
    /// The number of completed training jobs launched by the hyperparameter tuning
    /// job.
    completed: ?i32 = null,

    /// The number of in-progress training jobs launched by a hyperparameter tuning
    /// job.
    in_progress: ?i32 = null,

    /// The number of training jobs that failed and can't be retried. A failed
    /// training job can't be retried if it failed because a client error occurred.
    non_retryable_error: ?i32 = null,

    /// The number of training jobs that failed, but can be retried. A failed
    /// training job can be retried only if it failed because an internal service
    /// error occurred.
    retryable_error: ?i32 = null,

    /// The number of training jobs launched by a hyperparameter tuning job that
    /// were manually stopped.
    stopped: ?i32 = null,

    pub const json_field_names = .{
        .completed = "Completed",
        .in_progress = "InProgress",
        .non_retryable_error = "NonRetryableError",
        .retryable_error = "RetryableError",
        .stopped = "Stopped",
    };
};
