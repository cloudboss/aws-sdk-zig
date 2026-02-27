pub const ParticipantState = enum {
    connected,
    disconnected,

    pub const json_field_names = .{
        .connected = "CONNECTED",
        .disconnected = "DISCONNECTED",
    };
};
