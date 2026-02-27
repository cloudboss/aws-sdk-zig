pub const ShareRequestStatus = enum {
    active,
    replicating,
    shared,
    expiring,
    failed,
    expired,
    declined,
    revoked,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .replicating = "REPLICATING",
        .shared = "SHARED",
        .expiring = "EXPIRING",
        .failed = "FAILED",
        .expired = "EXPIRED",
        .declined = "DECLINED",
        .revoked = "REVOKED",
    };
};
