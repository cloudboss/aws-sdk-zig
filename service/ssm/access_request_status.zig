pub const AccessRequestStatus = enum {
    approved,
    rejected,
    revoked,
    expired,
    pending,

    pub const json_field_names = .{
        .approved = "APPROVED",
        .rejected = "REJECTED",
        .revoked = "REVOKED",
        .expired = "EXPIRED",
        .pending = "PENDING",
    };
};
