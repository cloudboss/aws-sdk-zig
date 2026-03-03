/// Contains information about the timeout configuration for a job.
pub const IoTJobTimeoutConfig = struct {
    /// The amount of time, in minutes, that devices have to complete the job. The
    /// timer starts
    /// when the job status is set to `IN_PROGRESS`. If the job status doesn't
    /// change to a
    /// terminal state before the time expires, then the job status is set to
    /// `TIMED_OUT`.
    ///
    /// The timeout interval must be between 1 minute and 7 days (10080 minutes).
    in_progress_timeout_in_minutes: ?i64 = null,

    pub const json_field_names = .{
        .in_progress_timeout_in_minutes = "inProgressTimeoutInMinutes",
    };
};
