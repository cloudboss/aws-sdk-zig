pub const SelfUpgradeRequestStatus = enum {
    pending,
    approved,
    denied,
    update_failed,
    verify_failed,

    pub const json_field_names = .{
        .pending = "PENDING",
        .approved = "APPROVED",
        .denied = "DENIED",
        .update_failed = "UPDATE_FAILED",
        .verify_failed = "VERIFY_FAILED",
    };
};
