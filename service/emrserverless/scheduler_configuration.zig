/// The scheduler configuration for batch and streaming jobs running on this
/// application. Supported with release labels emr-7.0.0 and above.
pub const SchedulerConfiguration = struct {
    /// The maximum concurrent job runs on this application. If scheduler
    /// configuration is enabled on your application, the default value is 15. The
    /// valid range is 1 to 1000.
    max_concurrent_runs: ?i32 = null,

    /// The maximum duration in minutes for the job in QUEUED state. If scheduler
    /// configuration is enabled on your application, the default value is 360
    /// minutes (6 hours). The valid range is from 15 to 720.
    queue_timeout_minutes: ?i32 = null,

    pub const json_field_names = .{
        .max_concurrent_runs = "maxConcurrentRuns",
        .queue_timeout_minutes = "queueTimeoutMinutes",
    };
};
