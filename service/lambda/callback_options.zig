/// Configuration options for callback operations in durable executions,
/// including timeout settings and retry behavior.
pub const CallbackOptions = struct {
    /// The heartbeat timeout for the callback operation, in seconds. If not
    /// specified or set to 0, heartbeat timeout is disabled.
    heartbeat_timeout_seconds: i32 = 0,

    /// The timeout for the callback operation in seconds. If not specified or set
    /// to 0, the callback has no timeout.
    timeout_seconds: i32 = 0,

    pub const json_field_names = .{
        .heartbeat_timeout_seconds = "HeartbeatTimeoutSeconds",
        .timeout_seconds = "TimeoutSeconds",
    };
};
