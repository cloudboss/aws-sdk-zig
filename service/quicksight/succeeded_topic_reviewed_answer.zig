/// The definition for a `SucceededTopicReviewedAnswer`.
pub const SucceededTopicReviewedAnswer = struct {
    /// The answer ID for the `SucceededTopicReviewedAnswer`.
    answer_id: ?[]const u8,

    pub const json_field_names = .{
        .answer_id = "AnswerId",
    };
};
