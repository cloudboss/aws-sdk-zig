/// Trigger configuration based on time.
pub const TimeBasedTriggerInput = struct {
    /// Idle session timeout (seconds) that triggers memory processing.
    idle_session_timeout: i32 = 20,

    pub const json_field_names = .{
        .idle_session_timeout = "idleSessionTimeout",
    };
};
