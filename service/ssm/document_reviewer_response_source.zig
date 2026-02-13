const DocumentReviewCommentSource = @import("document_review_comment_source.zig").DocumentReviewCommentSource;
const ReviewStatus = @import("review_status.zig").ReviewStatus;

/// Information about a reviewer's response to a document review request.
pub const DocumentReviewerResponseSource = struct {
    /// The comment entered by a reviewer as part of their document review response.
    comment: ?[]const DocumentReviewCommentSource,

    /// The date and time that a reviewer entered a response to a document review
    /// request.
    create_time: ?i64,

    /// The user in your organization assigned to review a document request.
    reviewer: ?[]const u8,

    /// The current review status of a new custom SSM document created by a member
    /// of your
    /// organization, or of the latest version of an existing SSM document.
    ///
    /// Only one version of a document can be in the APPROVED state at a time. When
    /// a new version is
    /// approved, the status of the previous version changes to REJECTED.
    ///
    /// Only one version of a document can be in review, or PENDING, at a time.
    review_status: ?ReviewStatus,

    /// The date and time that a reviewer last updated a response to a document
    /// review
    /// request.
    updated_time: ?i64,

    pub const json_field_names = .{
        .comment = "Comment",
        .create_time = "CreateTime",
        .reviewer = "Reviewer",
        .review_status = "ReviewStatus",
        .updated_time = "UpdatedTime",
    };
};
