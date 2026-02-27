pub const ConnectionState = enum {
    connected,
    disconnected,
    unknown,

    pub const json_field_names = .{
        .connected = "CONNECTED",
        .disconnected = "DISCONNECTED",
        .unknown = "UNKNOWN",
    };
};
