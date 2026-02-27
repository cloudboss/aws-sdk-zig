pub const StreamSessionStatus = enum {
    activating,
    active,
    connected,
    pending_client_reconnection,
    reconnecting,
    terminating,
    terminated,
    @"error",

    pub const json_field_names = .{
        .activating = "ACTIVATING",
        .active = "ACTIVE",
        .connected = "CONNECTED",
        .pending_client_reconnection = "PENDING_CLIENT_RECONNECTION",
        .reconnecting = "RECONNECTING",
        .terminating = "TERMINATING",
        .terminated = "TERMINATED",
        .@"error" = "ERROR",
    };
};
