/// The configuration that defines how agent sessions are detected and when they
/// are considered complete for evaluation.
pub const SessionConfig = struct {
    /// The number of minutes of inactivity after which an agent session is
    /// considered complete and ready for evaluation. Default is 15 minutes.
    session_timeout_minutes: i32,

    pub const json_field_names = .{
        .session_timeout_minutes = "sessionTimeoutMinutes",
    };
};
