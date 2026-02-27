pub const ContactState = enum {
    incoming,
    pending,
    connecting,
    connected,
    connected_onhold,
    missed,
    @"error",
    ended,
    rejected,

    pub const json_field_names = .{
        .incoming = "INCOMING",
        .pending = "PENDING",
        .connecting = "CONNECTING",
        .connected = "CONNECTED",
        .connected_onhold = "CONNECTED_ONHOLD",
        .missed = "MISSED",
        .@"error" = "ERROR",
        .ended = "ENDED",
        .rejected = "REJECTED",
    };
};
