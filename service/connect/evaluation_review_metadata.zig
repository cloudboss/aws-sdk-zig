const EvaluationReviewRequestComment = @import("evaluation_review_request_comment.zig").EvaluationReviewRequestComment;

/// Metadata information about an evaluation review.
pub const EvaluationReviewMetadata = struct {
    /// The user who created the evaluation review.
    created_by: []const u8,

    /// The timestamp when the evaluation review was created.
    created_time: i64,

    /// The unique identifier for the evaluation review.
    review_id: ?[]const u8,

    /// Comments provided when requesting the evaluation review.
    review_request_comments: []const EvaluationReviewRequestComment,

    pub const json_field_names = .{
        .created_by = "CreatedBy",
        .created_time = "CreatedTime",
        .review_id = "ReviewId",
        .review_request_comments = "ReviewRequestComments",
    };
};
