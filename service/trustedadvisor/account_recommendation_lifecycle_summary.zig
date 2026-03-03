const RecommendationLifecycleStage = @import("recommendation_lifecycle_stage.zig").RecommendationLifecycleStage;
const UpdateRecommendationLifecycleStageReasonCode = @import("update_recommendation_lifecycle_stage_reason_code.zig").UpdateRecommendationLifecycleStageReasonCode;

/// Summary of an AccountRecommendationLifecycle for an Organization
/// Recommendation
pub const AccountRecommendationLifecycleSummary = struct {
    /// The AWS account ID
    account_id: ?[]const u8 = null,

    /// The Recommendation ARN
    account_recommendation_arn: ?[]const u8 = null,

    /// When the Recommendation was last updated
    last_updated_at: ?i64 = null,

    /// The lifecycle stage from AWS Trusted Advisor Priority
    lifecycle_stage: ?RecommendationLifecycleStage = null,

    /// The person on whose behalf a Technical Account Manager (TAM) updated the
    /// recommendation. This information
    /// is only available when a Technical Account Manager takes an action on a
    /// recommendation managed by AWS
    /// Trusted Advisor Priority
    updated_on_behalf_of: ?[]const u8 = null,

    /// The job title of the person on whose behalf a Technical Account Manager
    /// (TAM) updated the recommendation.
    /// This information is only available when a Technical Account Manager takes an
    /// action on a recommendation
    /// managed by AWS Trusted Advisor Priority
    updated_on_behalf_of_job_title: ?[]const u8 = null,

    /// Reason for the lifecycle stage change
    update_reason: ?[]const u8 = null,

    /// Reason code for the lifecycle state change
    update_reason_code: ?UpdateRecommendationLifecycleStageReasonCode = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .account_recommendation_arn = "accountRecommendationArn",
        .last_updated_at = "lastUpdatedAt",
        .lifecycle_stage = "lifecycleStage",
        .updated_on_behalf_of = "updatedOnBehalfOf",
        .updated_on_behalf_of_job_title = "updatedOnBehalfOfJobTitle",
        .update_reason = "updateReason",
        .update_reason_code = "updateReasonCode",
    };
};
