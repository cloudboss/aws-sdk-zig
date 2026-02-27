pub const SubscriptionGrantStatus = enum {
    grant_pending,
    revoke_pending,
    grant_in_progress,
    revoke_in_progress,
    granted,
    revoked,
    grant_failed,
    revoke_failed,

    pub const json_field_names = .{
        .grant_pending = "GRANT_PENDING",
        .revoke_pending = "REVOKE_PENDING",
        .grant_in_progress = "GRANT_IN_PROGRESS",
        .revoke_in_progress = "REVOKE_IN_PROGRESS",
        .granted = "GRANTED",
        .revoked = "REVOKED",
        .grant_failed = "GRANT_FAILED",
        .revoke_failed = "REVOKE_FAILED",
    };
};
