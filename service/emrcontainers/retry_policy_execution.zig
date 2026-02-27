/// The current status of the retry policy executed on the job.
pub const RetryPolicyExecution = struct {
    /// The current number of attempts made on the driver of the job.
    current_attempt_count: i32,

    pub const json_field_names = .{
        .current_attempt_count = "currentAttemptCount",
    };
};
