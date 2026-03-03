const aws = @import("aws");

const LensStatus = @import("lens_status.zig").LensStatus;
const ReviewTemplatePillarReviewSummary = @import("review_template_pillar_review_summary.zig").ReviewTemplatePillarReviewSummary;

/// The lens review of a review template.
pub const ReviewTemplateLensReview = struct {
    lens_alias: ?[]const u8 = null,

    /// The lens ARN.
    lens_arn: ?[]const u8 = null,

    lens_name: ?[]const u8 = null,

    /// The status of the lens.
    lens_status: ?LensStatus = null,

    /// The version of the lens.
    lens_version: ?[]const u8 = null,

    next_token: ?[]const u8 = null,

    notes: ?[]const u8 = null,

    /// Pillar review summaries of a lens review.
    pillar_review_summaries: ?[]const ReviewTemplatePillarReviewSummary = null,

    /// A count of how many questions are answered and unanswered in the lens
    /// review.
    question_counts: ?[]const aws.map.MapEntry(i32) = null,

    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .lens_alias = "LensAlias",
        .lens_arn = "LensArn",
        .lens_name = "LensName",
        .lens_status = "LensStatus",
        .lens_version = "LensVersion",
        .next_token = "NextToken",
        .notes = "Notes",
        .pillar_review_summaries = "PillarReviewSummaries",
        .question_counts = "QuestionCounts",
        .updated_at = "UpdatedAt",
    };
};
