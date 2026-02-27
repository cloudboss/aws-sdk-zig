pub const ReviewStatus = enum {
    pending_submission,
    submitted,
    in_review,
    approved,
    rejected,
    action_required,

    pub const json_field_names = .{
        .pending_submission = "PENDING_SUBMISSION",
        .submitted = "SUBMITTED",
        .in_review = "IN_REVIEW",
        .approved = "APPROVED",
        .rejected = "REJECTED",
        .action_required = "ACTION_REQUIRED",
    };
};
