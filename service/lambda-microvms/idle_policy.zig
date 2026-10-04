/// Configuration that controls MicroVM auto-suspend and auto-resume behavior.
/// Idle time is measured by inbound traffic through the MicroVM proxy endpoint
/// — if no requests arrive within the configured duration, the MicroVM is
/// suspended.
pub const IdlePolicy = struct {
    /// Indicates whether the MicroVM automatically resumes when it receives a
    /// request while suspended.
    auto_resume_enabled: bool,

    /// The maximum time in seconds that a MicroVM can remain idle before it is
    /// automatically suspended.
    max_idle_duration_seconds: i32,

    /// The maximum time in seconds that a MicroVM can remain suspended before it is
    /// automatically terminated.
    suspended_duration_seconds: i32,

    pub const json_field_names = .{
        .auto_resume_enabled = "autoResumeEnabled",
        .max_idle_duration_seconds = "maxIdleDurationSeconds",
        .suspended_duration_seconds = "suspendedDurationSeconds",
    };
};
