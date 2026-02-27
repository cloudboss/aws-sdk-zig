const EvaluationTranscriptPointOfInterest = @import("evaluation_transcript_point_of_interest.zig").EvaluationTranscriptPointOfInterest;

/// An analysis for a generative AI answer to the question.
pub const EvaluationGenAIAnswerAnalysisDetails = struct {
    /// Generative AI automation answer justification.
    justification: ?[]const u8,

    /// Generative AI automation answer analysis points of interest.
    points_of_interest: ?[]const EvaluationTranscriptPointOfInterest,

    pub const json_field_names = .{
        .justification = "Justification",
        .points_of_interest = "PointsOfInterest",
    };
};
