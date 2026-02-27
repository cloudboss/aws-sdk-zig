pub const SessionConnectionState = enum {
    connected,
    not_connected,

    pub const json_field_names = .{
        .connected = "CONNECTED",
        .not_connected = "NOT_CONNECTED",
    };
};
