pub const InvitationStatus = enum {
    accepted,
    pending,
    rejected,
    expired,

    pub const json_field_names = .{
        .accepted = "ACCEPTED",
        .pending = "PENDING",
        .rejected = "REJECTED",
        .expired = "EXPIRED",
    };
};
