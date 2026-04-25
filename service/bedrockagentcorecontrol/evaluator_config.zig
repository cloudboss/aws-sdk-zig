const CodeBasedEvaluatorConfig = @import("code_based_evaluator_config.zig").CodeBasedEvaluatorConfig;
const LlmAsAJudgeEvaluatorConfig = @import("llm_as_a_judge_evaluator_config.zig").LlmAsAJudgeEvaluatorConfig;

/// The configuration that defines how an evaluator assesses agent performance,
/// including the evaluation method and parameters.
pub const EvaluatorConfig = union(enum) {
    /// Configuration for a code-based evaluator that uses a customer-managed Lambda
    /// function to programmatically assess agent performance.
    code_based: ?CodeBasedEvaluatorConfig,
    /// The LLM-as-a-Judge configuration that uses a language model to evaluate
    /// agent performance based on custom instructions and rating scales.
    llm_as_a_judge: ?LlmAsAJudgeEvaluatorConfig,

    pub const json_field_names = .{
        .code_based = "codeBased",
        .llm_as_a_judge = "llmAsAJudge",
    };
};
