const AwsProductsSpendInsightsBySource = @import("aws_products_spend_insights_by_source.zig").AwsProductsSpendInsightsBySource;
const EngagementScore = @import("engagement_score.zig").EngagementScore;

/// Contains insights provided by AWS for the opportunity, offering
/// recommendations and analysis that can help the partner optimize their
/// engagement and strategy.
pub const AwsOpportunityInsights = struct {
    /// Source-separated spend insights that provide independent analysis for AWS
    /// recommendations and partner estimates.
    aws_products_spend_insights_by_source: ?AwsProductsSpendInsightsBySource = null,

    /// Represents a score assigned by AWS to indicate the level of engagement and
    /// potential success for the opportunity. This score helps partners prioritize
    /// their efforts.
    engagement_score: ?EngagementScore = null,

    /// Provides recommendations from AWS on the next best actions to take in order
    /// to move the opportunity forward and increase the likelihood of success.
    next_best_actions: ?[]const u8 = null,

    pub const json_field_names = .{
        .aws_products_spend_insights_by_source = "AwsProductsSpendInsightsBySource",
        .engagement_score = "EngagementScore",
        .next_best_actions = "NextBestActions",
    };
};
