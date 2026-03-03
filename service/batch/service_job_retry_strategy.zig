const ServiceJobEvaluateOnExit = @import("service_job_evaluate_on_exit.zig").ServiceJobEvaluateOnExit;

/// The retry strategy for service jobs. This defines how many times to retry a
/// failed service job and under what conditions. For more information, see
/// [Service job retry
/// strategies](https://docs.aws.amazon.com/batch/latest/userguide/service-job-retries.html) in the *Batch User Guide*.
pub const ServiceJobRetryStrategy = struct {
    /// The number of times to move a service job to `RUNNABLE` status. You can
    /// specify between 1 and 10 attempts.
    attempts: i32,

    /// Array of `ServiceJobEvaluateOnExit` objects that specify conditions under
    /// which the service job should be retried or failed.
    evaluate_on_exit: ?[]const ServiceJobEvaluateOnExit = null,

    pub const json_field_names = .{
        .attempts = "attempts",
        .evaluate_on_exit = "evaluateOnExit",
    };
};
