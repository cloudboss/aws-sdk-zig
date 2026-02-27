/// The status of the share request.
pub const ShareStatus = enum {
    accepted,
    rejected,
    pending,
    revoked,
    expired,
    associating,
    associated,
    failed,

    pub const json_field_names = .{
        .accepted = "ACCEPTED",
        .rejected = "REJECTED",
        .pending = "PENDING",
        .revoked = "REVOKED",
        .expired = "EXPIRED",
        .associating = "ASSOCIATING",
        .associated = "ASSOCIATED",
        .failed = "FAILED",
    };
};
