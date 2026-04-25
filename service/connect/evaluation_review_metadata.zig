const EvaluationReviewRequestComment = @import("evaluation_review_request_comment.zig").EvaluationReviewRequestComment;

/// Metadata information about an evaluation review.
pub const EvaluationReviewMetadata = struct {
    /// The user who created the evaluation review.
    created_by: []const u8 = "n/a",

    /// The timestamp when the evaluation review was created.
    created_time: i64 = 0,

    /// The user who requested the evaluation review.
    requested_by: ?[]const u8 = null,

    /// The timestamp when the evaluation review was requested.
    requested_time: ?i64 = null,

    /// The unique identifier for the evaluation review.
    review_id: ?[]const u8 = null,

    /// Comments provided when requesting the evaluation review.
    review_request_comments: []const EvaluationReviewRequestComment,

    pub const json_field_names = .{
        .created_by = "CreatedBy",
        .created_time = "CreatedTime",
        .requested_by = "RequestedBy",
        .requested_time = "RequestedTime",
        .review_id = "ReviewId",
        .review_request_comments = "ReviewRequestComments",
    };
};
