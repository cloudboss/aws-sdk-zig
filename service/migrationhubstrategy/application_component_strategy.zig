const RecommendationSet = @import("recommendation_set.zig").RecommendationSet;
const StrategyRecommendation = @import("strategy_recommendation.zig").StrategyRecommendation;

/// Contains information about a strategy recommendation for an application
/// component.
pub const ApplicationComponentStrategy = struct {
    /// Set to true if the recommendation is set as preferred.
    is_preferred: ?bool,

    /// Strategy recommendation for the application component.
    recommendation: ?RecommendationSet,

    /// The recommendation status of a strategy for an application component.
    status: ?StrategyRecommendation,

    pub const json_field_names = .{
        .is_preferred = "isPreferred",
        .recommendation = "recommendation",
        .status = "status",
    };
};
