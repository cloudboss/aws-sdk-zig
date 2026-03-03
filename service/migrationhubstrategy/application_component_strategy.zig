const RecommendationSet = @import("recommendation_set.zig").RecommendationSet;
const StrategyRecommendation = @import("strategy_recommendation.zig").StrategyRecommendation;

/// Contains information about a strategy recommendation for an application
/// component.
pub const ApplicationComponentStrategy = struct {
    /// Set to true if the recommendation is set as preferred.
    is_preferred: ?bool = null,

    /// Strategy recommendation for the application component.
    recommendation: ?RecommendationSet = null,

    /// The recommendation status of a strategy for an application component.
    status: ?StrategyRecommendation = null,

    pub const json_field_names = .{
        .is_preferred = "isPreferred",
        .recommendation = "recommendation",
        .status = "status",
    };
};
