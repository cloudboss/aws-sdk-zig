pub const NetworkConnectionStatus = enum {
    connected,
    not_connected,
    connecting,

    pub const json_field_names = .{
        .connected = "CONNECTED",
        .not_connected = "NOT_CONNECTED",
        .connecting = "CONNECTING",
    };
};
