/// The session configuration for an MCP gateway. This structure defines
/// settings that control session behavior.
pub const SessionConfiguration = struct {
    /// The session timeout in seconds. After this timeout, the session expires and
    /// subsequent requests to this session will receive an error. The minimum value
    /// is 900 seconds (15 minutes), the maximum value is 28800 seconds (8 hours),
    /// and the default value is 3600 seconds (1 hour).
    session_timeout_in_seconds: ?i32 = null,

    pub const json_field_names = .{
        .session_timeout_in_seconds = "sessionTimeoutInSeconds",
    };
};
