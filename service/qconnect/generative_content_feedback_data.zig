const Relevance = @import("relevance.zig").Relevance;

/// The feedback information for a generative target type.
pub const GenerativeContentFeedbackData = struct {
    /// The relevance of the feedback.
    relevance: Relevance,

    pub const json_field_names = .{
        .relevance = "relevance",
    };
};
