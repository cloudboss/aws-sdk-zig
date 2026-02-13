const DocumentReviewAction = @import("document_review_action.zig").DocumentReviewAction;
const DocumentReviewCommentSource = @import("document_review_comment_source.zig").DocumentReviewCommentSource;

/// Information about a document approval review.
pub const DocumentReviews = struct {
    /// The action to take on a document approval review request.
    action: DocumentReviewAction,

    /// A comment entered by a user in your organization about the document review
    /// request.
    comment: ?[]const DocumentReviewCommentSource,

    pub const json_field_names = .{
        .action = "Action",
        .comment = "Comment",
    };
};
