pub const BenefitApplicationStatus = enum {
    pending_submission,
    in_review,
    action_required,
    approved,
    rejected,
    canceled,

    pub const json_field_names = .{
        .pending_submission = "PENDING_SUBMISSION",
        .in_review = "IN_REVIEW",
        .action_required = "ACTION_REQUIRED",
        .approved = "APPROVED",
        .rejected = "REJECTED",
        .canceled = "CANCELED",
    };
};
