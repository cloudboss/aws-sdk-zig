const UsefulnessRating = @import("usefulness_rating.zig").UsefulnessRating;

/// Represents user feedback for an investigation result. This structure
/// captures the user's evaluation of the investigation's quality, usefulness,
/// and any additional comments.
pub const InvestigationFeedback = struct {
    /// Optional user comments providing additional context about the investigation
    /// feedback. This allows users to explain their rating or provide suggestions
    /// for improvement.
    comment: ?[]const u8,

    /// ISO 8601 timestamp when the feedback was submitted. This records when the
    /// user provided their assessment of the investigation results.
    submitted_at: ?i64,

    /// User assessment of the investigation result's quality and helpfulness. This
    /// rating indicates how valuable the investigation findings were in addressing
    /// the case.
    usefulness: ?UsefulnessRating,

    pub const json_field_names = .{
        .comment = "comment",
        .submitted_at = "submittedAt",
        .usefulness = "usefulness",
    };
};
