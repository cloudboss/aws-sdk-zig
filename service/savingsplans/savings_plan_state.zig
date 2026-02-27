pub const SavingsPlanState = enum {
    payment_pending,
    payment_failed,
    active,
    retired,
    queued,
    queued_deleted,
    pending_return,
    returned,

    pub const json_field_names = .{
        .payment_pending = "PAYMENT_PENDING",
        .payment_failed = "PAYMENT_FAILED",
        .active = "ACTIVE",
        .retired = "RETIRED",
        .queued = "QUEUED",
        .queued_deleted = "QUEUED_DELETED",
        .pending_return = "PENDING_RETURN",
        .returned = "RETURNED",
    };
};
