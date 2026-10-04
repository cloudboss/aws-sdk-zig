const CodeBasedEvaluatorConfig = @import("code_based_evaluator_config.zig").CodeBasedEvaluatorConfig;
const DerivedEvaluatorConfig = @import("derived_evaluator_config.zig").DerivedEvaluatorConfig;
const LlmAsAJudgeEvaluatorConfig = @import("llm_as_a_judge_evaluator_config.zig").LlmAsAJudgeEvaluatorConfig;

/// The configuration that defines how an evaluator assesses agent performance,
/// including the evaluation method and parameters.
pub const EvaluatorConfig = union(enum) {
    /// Configuration for a code-based evaluator that uses a customer-managed Lambda
    /// function to programmatically assess agent performance.
    code_based: ?CodeBasedEvaluatorConfig,
    /// The configuration for an evaluator derived from an existing base evaluator
    /// (a built-in or third-party evaluator), run on your own model. The base
    /// evaluator supplies the prompt and scoring.
    derived: ?DerivedEvaluatorConfig,
    /// The LLM-as-a-Judge configuration that uses a language model to evaluate
    /// agent performance based on custom instructions and rating scales.
    llm_as_a_judge: ?LlmAsAJudgeEvaluatorConfig,

    pub const json_field_names = .{
        .code_based = "codeBased",
        .derived = "derived",
        .llm_as_a_judge = "llmAsAJudge",
    };
};
