/// LifecycleConfiguration lets you manage the lifecycle of runtime sessions and
/// resources in AgentCore Runtime. This configuration helps optimize resource
/// utilization by automatically cleaning up idle sessions and preventing
/// long-running instances from consuming resources indefinitely.
pub const LifecycleConfiguration = struct {
    /// Timeout in seconds for idle runtime sessions. When a session remains idle
    /// for this duration, it will be automatically terminated. Default: 900 seconds
    /// (15 minutes).
    idle_runtime_session_timeout: ?i32 = null,

    /// Maximum lifetime for the instance in seconds. Once reached, instances will
    /// be automatically terminated and replaced. Default: 28800 seconds (8 hours).
    max_lifetime: ?i32 = null,

    pub const json_field_names = .{
        .idle_runtime_session_timeout = "idleRuntimeSessionTimeout",
        .max_lifetime = "maxLifetime",
    };
};
