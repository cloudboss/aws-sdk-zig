const aws = @import("aws");

const JiraSelectedQuestionConfiguration = @import("jira_selected_question_configuration.zig").JiraSelectedQuestionConfiguration;
const LensStatus = @import("lens_status.zig").LensStatus;
const PillarReviewSummary = @import("pillar_review_summary.zig").PillarReviewSummary;
const WorkloadProfile = @import("workload_profile.zig").WorkloadProfile;

/// A lens review of a question.
pub const LensReview = struct {
    /// Jira configuration status of the Lens review.
    jira_configuration: ?JiraSelectedQuestionConfiguration,

    lens_alias: ?[]const u8,

    /// The ARN for the lens.
    lens_arn: ?[]const u8,

    lens_name: ?[]const u8,

    /// The status of the lens.
    lens_status: ?LensStatus,

    /// The version of the lens.
    lens_version: ?[]const u8,

    next_token: ?[]const u8,

    notes: ?[]const u8,

    pillar_review_summaries: ?[]const PillarReviewSummary,

    prioritized_risk_counts: ?[]const aws.map.MapEntry(i32),

    /// The profiles associated with the workload.
    profiles: ?[]const WorkloadProfile,

    risk_counts: ?[]const aws.map.MapEntry(i32),

    updated_at: ?i64,

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
