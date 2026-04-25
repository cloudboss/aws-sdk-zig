/// A comment provided when requesting an evaluation review.
pub const EvaluationReviewRequestComment = struct {
    /// The text content of the review request comment.
    comment: ?[]const u8 = null,

    /// The user who created the evaluation review request comment.
    created_by: ?[]const u8 = null,

    /// The timestamp when the evaluation review request comment was created.
    created_time: ?i64 = null,

    pub const json_field_names = .{
        .comment = "Comment",
        .created_by = "CreatedBy",
        .created_time = "CreatedTime",
    };
};
