const EvaluateOnExit = @import("evaluate_on_exit.zig").EvaluateOnExit;

/// The retry strategy that's associated with a job. For more information, see
/// [Automated job
/// retries](https://docs.aws.amazon.com/batch/latest/userguide/job_retries.html) in the
/// *Batch User Guide*.
pub const RetryStrategy = struct {
    /// The number of times to move a job to the `RUNNABLE` status. You can specify
    /// between 1 and 10 attempts. If the value of `attempts` is greater than one,
    /// the job is
    /// retried on failure the same number of attempts as the value.
    attempts: ?i32 = null,

    /// Array of up to 5 objects that specify the conditions where jobs are retried
    /// or failed. If
    /// this parameter is specified, then the `attempts` parameter must also be
    /// specified. If
    /// none of the listed conditions match, then the job is retried.
    evaluate_on_exit: ?[]const EvaluateOnExit = null,

    pub const json_field_names = .{
        .attempts = "attempts",
        .evaluate_on_exit = "evaluateOnExit",
    };
};
