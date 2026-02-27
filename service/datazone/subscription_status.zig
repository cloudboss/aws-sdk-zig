pub const SubscriptionStatus = enum {
    approved,
    revoked,
    cancelled,

    pub const json_field_names = .{
        .approved = "APPROVED",
        .revoked = "REVOKED",
        .cancelled = "CANCELLED",
    };
};
