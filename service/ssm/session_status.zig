pub const SessionStatus = enum {
    connected,
    connecting,
    disconnected,
    terminated,
    terminating,
    failed,

    pub const json_field_names = .{
        .connected = "CONNECTED",
        .connecting = "CONNECTING",
        .disconnected = "DISCONNECTED",
        .terminated = "TERMINATED",
        .terminating = "TERMINATING",
        .failed = "FAILED",
    };
};
