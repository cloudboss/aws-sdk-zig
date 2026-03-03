const RecommendationSet = @import("recommendation_set.zig").RecommendationSet;
const StrategyRecommendation = @import("strategy_recommendation.zig").StrategyRecommendation;

/// Contains information about a strategy recommendation for a server.
pub const ServerStrategy = struct {
    /// Set to true if the recommendation is set as preferred.
    is_preferred: ?bool = null,

    /// The number of application components with this strategy recommendation
    /// running on the
    /// server.
    number_of_application_components: ?i32 = null,

    /// Strategy recommendation for the server.
    recommendation: ?RecommendationSet = null,

    /// The recommendation status of the strategy for the server.
    status: ?StrategyRecommendation = null,

    pub const json_field_names = .{
        .is_preferred = "isPreferred",
        .number_of_application_components = "numberOfApplicationComponents",
        .recommendation = "recommendation",
        .status = "status",
    };
};
