const DocumentReviewerResponseSource = @import("document_reviewer_response_source.zig").DocumentReviewerResponseSource;

/// Details about the response to a document review request.
pub const DocumentMetadataResponseInfo = struct {
    /// Details about a reviewer's response to a document review request.
    reviewer_response: ?[]const DocumentReviewerResponseSource,

    pub const json_field_names = .{
        .reviewer_response = "ReviewerResponse",
    };
};
