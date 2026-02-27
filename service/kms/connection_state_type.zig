pub const ConnectionStateType = enum {
    connected,
    connecting,
    failed,
    disconnected,
    disconnecting,

    pub const json_field_names = .{
        .connected = "CONNECTED",
        .connecting = "CONNECTING",
        .failed = "FAILED",
        .disconnected = "DISCONNECTED",
        .disconnecting = "DISCONNECTING",
    };
};
