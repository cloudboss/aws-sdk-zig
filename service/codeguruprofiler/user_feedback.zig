const FeedbackType = @import("feedback_type.zig").FeedbackType;

/// Feedback that can be submitted for each instance of an anomaly by the user.
/// Feedback is be used for improvements in generating recommendations for the
/// application.
pub const UserFeedback = struct {
    /// Optional `Positive` or `Negative` feedback submitted by
    /// the user about whether the recommendation is useful or not.
    @"type": FeedbackType,

    pub const json_field_names = .{
        .@"type" = "type",
    };
};
