const RecommendationCostOptimizingAggregates = @import("recommendation_cost_optimizing_aggregates.zig").RecommendationCostOptimizingAggregates;

/// Recommendation pillar aggregates
pub const RecommendationPillarSpecificAggregates = struct {
    /// Cost optimizing aggregates
    cost_optimizing: ?RecommendationCostOptimizingAggregates,

    pub const json_field_names = .{
        .cost_optimizing = "costOptimizing",
    };
};
