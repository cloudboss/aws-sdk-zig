const EvaluatorModelConfig = @import("evaluator_model_config.zig").EvaluatorModelConfig;
const RatingScale = @import("rating_scale.zig").RatingScale;

/// The configuration for LLM-as-a-Judge evaluation that uses a language model
/// to assess agent performance based on custom instructions and rating scales.
pub const LlmAsAJudgeEvaluatorConfig = struct {
    /// The evaluation instructions that guide the language model in assessing agent
    /// performance, including criteria and evaluation guidelines.
    instructions: []const u8,

    /// The model configuration that specifies which foundation model to use and how
    /// to configure it for evaluation.
    model_config: EvaluatorModelConfig,

    /// The rating scale that defines how the evaluator should score agent
    /// performance, either numerical or categorical.
    rating_scale: RatingScale,

    pub const json_field_names = .{
        .instructions = "instructions",
        .model_config = "modelConfig",
        .rating_scale = "ratingScale",
    };
};
