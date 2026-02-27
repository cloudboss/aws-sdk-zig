const DocumentReviewCommentType = @import("document_review_comment_type.zig").DocumentReviewCommentType;

/// Information about comments added to a document review request.
pub const DocumentReviewCommentSource = struct {
    /// The content of a comment entered by a user who requests a review of a new
    /// document version,
    /// or who reviews the new version.
    content: ?[]const u8,

    /// The type of information added to a review request. Currently, only the value
    /// `Comment` is supported.
    type: ?DocumentReviewCommentType,

    pub const json_field_names = .{
        .content = "Content",
        .type = "Type",
    };
};
