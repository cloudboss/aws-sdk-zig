pub const ResourceShareInvitationStatus = enum {
    pending,
    accepted,
    rejected,
    expired,

    pub const json_field_names = .{
        .pending = "PENDING",
        .accepted = "ACCEPTED",
        .rejected = "REJECTED",
        .expired = "EXPIRED",
    };
};
