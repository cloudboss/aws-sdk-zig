const InsightFeedbackOption = @import("insight_feedback_option.zig").InsightFeedbackOption;

/// Information about insight feedback received from a customer.
pub const InsightFeedback = struct {
    /// The feedback provided by the customer.
    feedback: ?InsightFeedbackOption,

    /// The insight feedback ID.
    id: ?[]const u8,

    pub const json_field_names = .{
        .feedback = "Feedback",
        .id = "Id",
    };
};
