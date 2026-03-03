/// The retry policy to use for a job run.
pub const RetryPolicy = struct {
    /// Maximum number of attempts for the job run. This parameter is only
    /// applicable for `BATCH` mode.
    max_attempts: ?i32 = null,

    /// Maximum number of failed attempts per hour. This [arameter is only
    /// applicable for `STREAMING` mode.
    max_failed_attempts_per_hour: ?i32 = null,

    pub const json_field_names = .{
        .max_attempts = "maxAttempts",
        .max_failed_attempts_per_hour = "maxFailedAttemptsPerHour",
    };
};
