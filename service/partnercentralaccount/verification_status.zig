pub const VerificationStatus = enum {
    pending_customer_action,
    in_progress,
    failed,
    succeeded,
    rejected,

    pub const json_field_names = .{
        .pending_customer_action = "PENDING_CUSTOMER_ACTION",
        .in_progress = "IN_PROGRESS",
        .failed = "FAILED",
        .succeeded = "SUCCEEDED",
        .rejected = "REJECTED",
    };
};
