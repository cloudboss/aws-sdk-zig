pub const InvitationStatus = enum {
    pending,
    accepted,
    accepting,
    rejected,
    expired,

    pub const json_field_names = .{
        .pending = "PENDING",
        .accepted = "ACCEPTED",
        .accepting = "ACCEPTING",
        .rejected = "REJECTED",
        .expired = "EXPIRED",
    };
};
