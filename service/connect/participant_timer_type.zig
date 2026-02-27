pub const ParticipantTimerType = enum {
    idle,
    disconnect_noncustomer,

    pub const json_field_names = .{
        .idle = "IDLE",
        .disconnect_noncustomer = "DISCONNECT_NONCUSTOMER",
    };
};
