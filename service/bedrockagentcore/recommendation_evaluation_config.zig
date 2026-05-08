const RecommendationEvaluatorReference = @import("recommendation_evaluator_reference.zig").RecommendationEvaluatorReference;

/// The evaluation configuration for assessing recommendation quality.
pub const RecommendationEvaluationConfig = struct {
    /// The list of evaluators to use for assessing recommendation quality.
    evaluators: []const RecommendationEvaluatorReference,

    pub const json_field_names = .{
        .evaluators = "evaluators",
    };
};
