pub const HandshakeState = enum {
    requested,
    open,
    canceled,
    accepted,
    declined,
    expired,

    pub const json_field_names = .{
        .requested = "REQUESTED",
        .open = "OPEN",
        .canceled = "CANCELED",
        .accepted = "ACCEPTED",
        .declined = "DECLINED",
        .expired = "EXPIRED",
    };
};
