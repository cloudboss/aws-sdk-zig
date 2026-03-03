const aws = @import("aws");

/// Summary of a review template.
pub const ReviewTemplatePillarReviewSummary = struct {
    notes: ?[]const u8 = null,

    pillar_id: ?[]const u8 = null,

    pillar_name: ?[]const u8 = null,

    /// A count of how many questions are answered and unanswered in the requested
    /// pillar of the lens review.
    question_counts: ?[]const aws.map.MapEntry(i32) = null,

    pub const json_field_names = .{
        .notes = "Notes",
        .pillar_id = "PillarId",
        .pillar_name = "PillarName",
        .question_counts = "QuestionCounts",
    };
};
