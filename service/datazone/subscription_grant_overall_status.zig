pub const SubscriptionGrantOverallStatus = enum {
    pending,
    in_progress,
    grant_failed,
    revoke_failed,
    grant_and_revoke_failed,
    completed,
    inaccessible,

    pub const json_field_names = .{
        .pending = "PENDING",
        .in_progress = "IN_PROGRESS",
        .grant_failed = "GRANT_FAILED",
        .revoke_failed = "REVOKE_FAILED",
        .grant_and_revoke_failed = "GRANT_AND_REVOKE_FAILED",
        .completed = "COMPLETED",
        .inaccessible = "INACCESSIBLE",
    };
};
