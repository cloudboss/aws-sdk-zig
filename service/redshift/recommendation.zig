const ImpactRankingType = @import("impact_ranking_type.zig").ImpactRankingType;
const RecommendedAction = @import("recommended_action.zig").RecommendedAction;
const ReferenceLink = @import("reference_link.zig").ReferenceLink;

/// An Amazon Redshift Advisor recommended action on the Amazon Redshift
/// cluster.
pub const Recommendation = struct {
    /// The unique identifier of the cluster for which the recommendation is
    /// returned.
    cluster_identifier: ?[]const u8 = null,

    /// The date and time (UTC) that the recommendation was created.
    created_at: ?i64 = null,

    /// The description of the recommendation.
    description: ?[]const u8 = null,

    /// A unique identifier of the Advisor recommendation.
    id: ?[]const u8 = null,

    /// The scale of the impact that the Advisor recommendation has to the
    /// performance and cost of the cluster.
    impact_ranking: ?ImpactRankingType = null,

    /// The Amazon Redshift cluster namespace ARN for which the recommendations is
    /// returned.
    namespace_arn: ?[]const u8 = null,

    /// The description of what was observed about your cluster.
    observation: ?[]const u8 = null,

    /// The description of the recommendation.
    recommendation_text: ?[]const u8 = null,

    /// The type of Advisor recommendation.
    recommendation_type: ?[]const u8 = null,

    /// List of Amazon Redshift recommended actions.
    recommended_actions: ?[]const RecommendedAction = null,

    /// List of helpful links for more information about the Advisor recommendation.
    reference_links: ?[]const ReferenceLink = null,

    /// The title of the recommendation.
    title: ?[]const u8 = null,
};
