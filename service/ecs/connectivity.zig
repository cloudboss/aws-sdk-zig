pub const Connectivity = enum {
    connected,
    disconnected,

    pub const json_field_names = .{
        .connected = "CONNECTED",
        .disconnected = "DISCONNECTED",
    };
};
