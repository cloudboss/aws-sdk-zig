const aws = @import("aws");

const JiraSelectedQuestionConfiguration = @import("jira_selected_question_configuration.zig").JiraSelectedQuestionConfiguration;
const LensStatus = @import("lens_status.zig").LensStatus;
const PillarReviewSummary = @import("pillar_review_summary.zig").PillarReviewSummary;
const WorkloadProfile = @import("workload_profile.zig").WorkloadProfile;

/// A lens review of a question.
pub const LensReview = struct {
    /// Jira configuration status of the Lens review.
    jira_configuration: ?JiraSelectedQuestionConfiguration = null,

    lens_alias: ?[]const u8 = null,

    /// The ARN for the lens.
    lens_arn: ?[]const u8 = null,

    lens_name: ?[]const u8 = null,

    /// The status of the lens.
    lens_status: ?LensStatus = null,

    /// The version of the lens.
    lens_version: ?[]const u8 = null,

    next_token: ?[]const u8 = null,

    notes: ?[]const u8 = null,

    pillar_review_summaries: ?[]const PillarReviewSummary = null,

    prioritized_risk_counts: ?[]const aws.map.MapEntry(i32) = null,

    /// The profiles associated with the workload.
    profiles: ?[]const WorkloadProfile = null,

    risk_counts: ?[]const aws.map.MapEntry(i32) = null,

    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .jira_configuration = "JiraConfiguration",
        .lens_alias = "LensAlias",
        .lens_arn = "LensArn",
        .lens_name = "LensName",
        .lens_status = "LensStatus",
        .lens_version = "LensVersion",
        .next_token = "NextToken",
        .notes = "Notes",
        .pillar_review_summaries = "PillarReviewSummaries",
        .prioritized_risk_counts = "PrioritizedRiskCounts",
        .profiles = "Profiles",
        .risk_counts = "RiskCounts",
        .updated_at = "UpdatedAt",
    };
};
