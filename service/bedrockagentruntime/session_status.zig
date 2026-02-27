pub const SessionStatus = enum {
    active,
    expired,
    ended,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .expired = "EXPIRED",
        .ended = "ENDED",
    };
};
