const GenerativeContentFeedbackData = @import("generative_content_feedback_data.zig").GenerativeContentFeedbackData;

/// Information about the feedback.
pub const ContentFeedbackData = union(enum) {
    /// Information about the feedback for a generative target type.
    generative_content_feedback_data: ?GenerativeContentFeedbackData,

    pub const json_field_names = .{
        .generative_content_feedback_data = "generativeContentFeedbackData",
    };
};
