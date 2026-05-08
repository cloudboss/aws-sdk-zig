const AgentTracesConfig = @import("agent_traces_config.zig").AgentTracesConfig;
const RecommendationEvaluationConfig = @import("recommendation_evaluation_config.zig").RecommendationEvaluationConfig;
const SystemPromptConfig = @import("system_prompt_config.zig").SystemPromptConfig;

/// Configuration for generating system prompt optimization recommendations.
pub const SystemPromptRecommendationConfig = struct {
    /// The agent traces to analyze for generating recommendations.
    agent_traces: AgentTracesConfig,

    /// The evaluation configuration specifying which evaluator to use for assessing
    /// recommendation quality.
    evaluation_config: RecommendationEvaluationConfig,

    /// The current system prompt to optimize.
    system_prompt: SystemPromptConfig,

    pub const json_field_names = .{
        .agent_traces = "agentTraces",
        .evaluation_config = "evaluationConfig",
        .system_prompt = "systemPrompt",
    };
};
