/// Describes the timeout settings for a pool of WorkSpaces.
pub const TimeoutSettings = struct {
    /// Specifies the amount of time, in seconds, that a streaming session remains
    /// active after users disconnect.
    /// If users try to reconnect to the streaming session after a disconnection or
    /// network interruption
    /// within the time set, they are connected to their previous session.
    /// Otherwise, they are connected
    /// to a new session with a new streaming instance.
    disconnect_timeout_in_seconds: ?i32 = null,

    /// The amount of time in seconds a connection will stay active while idle.
    idle_disconnect_timeout_in_seconds: ?i32 = null,

    /// Specifies the maximum amount of time, in seconds, that a streaming session
    /// can remain active.
    /// If users are still connected to a streaming instance five minutes before
    /// this limit is reached,
    /// they are prompted to save any open documents before being disconnected.
    /// After this time elapses,
    /// the instance is terminated and replaced by a new instance.
    max_user_duration_in_seconds: ?i32 = null,

    pub const json_field_names = .{
        .disconnect_timeout_in_seconds = "DisconnectTimeoutInSeconds",
        .idle_disconnect_timeout_in_seconds = "IdleDisconnectTimeoutInSeconds",
        .max_user_duration_in_seconds = "MaxUserDurationInSeconds",
    };
};
