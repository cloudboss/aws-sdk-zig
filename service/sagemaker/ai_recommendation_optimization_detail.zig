const aws = @import("aws");

const AIRecommendationOptimizationType = @import("ai_recommendation_optimization_type.zig").AIRecommendationOptimizationType;

/// Details about an optimization technique applied in a recommendation.
pub const AIRecommendationOptimizationDetail = struct {
    /// A map of configuration parameters for the optimization technique.
    optimization_config: ?[]const aws.map.StringMapEntry = null,

    /// The type of optimization. Valid values are `SpeculativeDecoding` and
    /// `KernelTuning`.
    optimization_type: AIRecommendationOptimizationType,

    pub const json_field_names = .{
        .optimization_config = "OptimizationConfig",
        .optimization_type = "OptimizationType",
    };
};
