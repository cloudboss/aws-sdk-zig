/// The connectivity status of the thing.
pub const ThingConnectivity = struct {
    /// True if the thing is connected to the Amazon Web Services IoT Core service;
    /// false if it is not
    /// connected.
    connected: ?bool = null,

    /// The reason why the client is disconnected. If the thing has been
    /// disconnected for approximately an hour, the `disconnectReason` value might
    /// be missing.
    disconnect_reason: ?[]const u8 = null,

    /// The epoch time (in milliseconds) when the thing last connected or
    /// disconnected. If the
    /// thing has been disconnected for approximately an hour, the time value might
    /// be missing.
    timestamp: ?i64 = null,

    pub const json_field_names = .{
        .connected = "connected",
        .disconnect_reason = "disconnectReason",
        .timestamp = "timestamp",
    };
};
