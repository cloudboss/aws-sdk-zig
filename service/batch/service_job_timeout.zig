/// The timeout configuration for service jobs.
pub const ServiceJobTimeout = struct {
    /// The maximum duration in seconds that a service job attempt can run. After
    /// this time is reached, Batch terminates the service job attempt.
    attempt_duration_seconds: ?i32 = null,

    pub const json_field_names = .{
        .attempt_duration_seconds = "attemptDurationSeconds",
    };
};
