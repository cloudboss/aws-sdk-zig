pub const ParticipantState = enum {
    initial,
    connected,
    disconnected,
    missed,

    pub const json_field_names = .{
        .initial = "INITIAL",
        .connected = "CONNECTED",
        .disconnected = "DISCONNECTED",
        .missed = "MISSED",
    };
};
