const ReviewedAnswerErrorCode = @import("reviewed_answer_error_code.zig").ReviewedAnswerErrorCode;

/// The definition for a `InvalidTopicReviewedAnswer`.
pub const InvalidTopicReviewedAnswer = struct {
    /// The answer ID for the `InvalidTopicReviewedAnswer`.
    answer_id: ?[]const u8,

    /// The error that is returned for the `InvalidTopicReviewedAnswer`.
    @"error": ?ReviewedAnswerErrorCode,

    pub const json_field_names = .{
        .answer_id = "AnswerId",
        .@"error" = "Error",
    };
};
