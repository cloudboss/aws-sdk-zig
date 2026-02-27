pub const HandshakeStatus = enum {
    pending,
    accepted,
    rejected,
    canceled,
    expired,

    pub const json_field_names = .{
        .pending = "PENDING",
        .accepted = "ACCEPTED",
        .rejected = "REJECTED",
        .canceled = "CANCELED",
        .expired = "EXPIRED",
    };
};
