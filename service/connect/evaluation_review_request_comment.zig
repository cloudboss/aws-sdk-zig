/// A comment provided when requesting an evaluation review.
pub const EvaluationReviewRequestComment = struct {
    /// The text content of the review request comment.
    comment: ?[]const u8,

    /// The user who created the review request comment.
    created_by: ?[]const u8,

    /// The timestamp when the review request comment was created.
    created_time: ?i64,

    pub const json_field_names = .{
        .comment = "Comment",
        .created_by = "CreatedBy",
        .created_time = "CreatedTime",
    };
};
