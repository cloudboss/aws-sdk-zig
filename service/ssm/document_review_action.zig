pub const DocumentReviewAction = enum {
    send_for_review,
    update_review,
    approve,
    reject,

    pub const json_field_names = .{
        .send_for_review = "SendForReview",
        .update_review = "UpdateReview",
        .approve = "Approve",
        .reject = "Reject",
    };
};
