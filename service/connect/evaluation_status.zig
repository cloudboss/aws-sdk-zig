pub const EvaluationStatus = enum {
    draft,
    submitted,
    review_requested,
    under_review,

    pub const json_field_names = .{
        .draft = "DRAFT",
        .submitted = "SUBMITTED",
        .review_requested = "REVIEW_REQUESTED",
        .under_review = "UNDER_REVIEW",
    };
};
