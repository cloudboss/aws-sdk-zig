/// The retry strategy that's associated with a job. For more information, see [
/// Automated job
/// retries](https://docs.aws.amazon.com/batch/latest/userguide/job_retries.html) in the *Batch User Guide*.
pub const BatchRetryStrategy = struct {
    /// The number of times to move a job to the `RUNNABLE` status. If the value of
    /// `attempts` is greater than one, the job is retried on failure the same
    /// number
    /// of attempts as the value.
    attempts: ?i32 = null,

    pub const json_field_names = .{
        .attempts = "Attempts",
    };
};
