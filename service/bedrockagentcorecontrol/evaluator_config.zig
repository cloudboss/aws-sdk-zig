const LlmAsAJudgeEvaluatorConfig = @import("llm_as_a_judge_evaluator_config.zig").LlmAsAJudgeEvaluatorConfig;

/// The configuration that defines how an evaluator assesses agent performance,
/// including the evaluation method and parameters.
pub const EvaluatorConfig = union(enum) {
    /// The LLM-as-a-Judge configuration that uses a language model to evaluate
    /// agent performance based on custom instructions and rating scales.
    llm_as_a_judge: ?LlmAsAJudgeEvaluatorConfig,

    pub const json_field_names = .{
        .llm_as_a_judge = "llmAsAJudge",
    };
};
