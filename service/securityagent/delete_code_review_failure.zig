/// Contains information about a code review that failed to delete.
pub const DeleteCodeReviewFailure = struct {
    /// The unique identifier of the code review that failed to delete.
    code_review_id: ?[]const u8 = null,

    /// The reason the code review failed to delete.
    reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .code_review_id = "codeReviewId",
        .reason = "reason",
    };
};
