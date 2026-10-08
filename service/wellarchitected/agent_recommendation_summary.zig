const Effort = @import("effort.zig").Effort;
const ImpactCategory = @import("impact_category.zig").ImpactCategory;
const Pillar = @import("pillar.zig").Pillar;
const Priority = @import("priority.zig").Priority;
const Roi = @import("roi.zig").Roi;
const RecommendationState = @import("recommendation_state.zig").RecommendationState;
const RecommendationStatus = @import("recommendation_status.zig").RecommendationStatus;
const RecommendationType = @import("recommendation_type.zig").RecommendationType;

/// Summary of an agent optimization recommendation returned by list operations.
pub const AgentRecommendationSummary = struct {
    /// The applications that the recommendation targets.
    applications: ?[]const []const u8 = null,

    /// The Amazon Web Services services that the recommendation applies to.
    aws_services: ?[]const []const u8 = null,

    /// The business units that own the affected resources.
    business_units: ?[]const []const u8 = null,

    /// The timestamp when the recommendation was created.
    created_at: i64,

    /// The identifier of the user or system that created this recommendation.
    created_by: []const u8,

    /// A description of the recommendation.
    description: []const u8,

    /// The effort required to implement the recommendation.
    effort: Effort,

    /// The identifier of the generation process that produced this recommendation.
    generation_id: ?[]const u8 = null,

    /// The severity of the recommendation's impact.
    impact: ImpactCategory,

    /// The timestamp when the recommendation was last modified.
    last_modified_at: ?i64 = null,

    /// The identifier of the user or system that last modified this recommendation.
    last_modified_by: ?[]const u8 = null,

    /// The number of Amazon Web Services resources this recommendation affects.
    number_of_resources: ?i32 = null,

    /// The Well-Architected Tool Framework pillar that the recommendation
    /// addresses.
    pillar: Pillar,

    /// The priority of the recommendation.
    priority: Priority,

    /// The Amazon Resource Name (ARN) of the associated profile.
    profile_arn: []const u8,

    /// The Amazon Resource Name (ARN) of the recommendation.
    recommendation_arn: []const u8,

    /// The return on investment estimate for the recommendation.
    roi: Roi,

    /// The current state of the recommendation.
    state: RecommendationState,

    /// The current status of the recommendation.
    status: RecommendationStatus,

    /// The title of the recommendation.
    title: []const u8,

    /// The type of the recommendation.
    type: RecommendationType,

    /// The free-text reason associated with the recommendation's most recent status
    /// update.
    update_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .applications = "applications",
        .aws_services = "awsServices",
        .business_units = "businessUnits",
        .created_at = "createdAt",
        .created_by = "createdBy",
        .description = "description",
        .effort = "effort",
        .generation_id = "generationId",
        .impact = "impact",
        .last_modified_at = "lastModifiedAt",
        .last_modified_by = "lastModifiedBy",
        .number_of_resources = "numberOfResources",
        .pillar = "pillar",
        .priority = "priority",
        .profile_arn = "profileArn",
        .recommendation_arn = "recommendationArn",
        .roi = "roi",
        .state = "state",
        .status = "status",
        .title = "title",
        .type = "type",
        .update_reason = "updateReason",
    };
};
