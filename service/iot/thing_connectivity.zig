/// The connectivity status of the thing.
pub const ThingConnectivity = struct {
    /// Indicates whether the client is using a clean session. Returns `true` for
    /// clean sessions.
    clean_session: ?bool = null,

    /// The unique identifier of the MQTT client.
    client_id: ?[]const u8 = null,

    /// True if the thing is connected to the Amazon Web Services IoT Core service;
    /// false if it is not
    /// connected.
    connected: ?bool = null,

    /// The reason that the client is disconnected.
    disconnect_reason: ?[]const u8 = null,

    /// The keep-alive interval in seconds that the client specified when
    /// establishing the connection.
    keep_alive_duration: ?i32 = null,

    /// The session expiry interval in seconds for the MQTT client connection. This
    /// value indicates how long the session will remain active after the client
    /// disconnects.
    session_expiry: ?i64 = null,

    /// The epoch time (in milliseconds) when the thing last connected or
    /// disconnected.
    timestamp: ?i64 = null,

    pub const json_field_names = .{
        .clean_session = "cleanSession",
        .client_id = "clientId",
        .connected = "connected",
        .disconnect_reason = "disconnectReason",
        .keep_alive_duration = "keepAliveDuration",
        .session_expiry = "sessionExpiry",
        .timestamp = "timestamp",
    };
};
