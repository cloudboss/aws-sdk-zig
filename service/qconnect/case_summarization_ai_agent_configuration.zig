/// The configuration for AI Agents of type `CASE_SUMMARIZATION`.
pub const CaseSummarizationAIAgentConfiguration = struct {
    /// The AI Guardrail identifier used by the Case Summarization AI Agent.
    case_summarization_ai_guardrail_id: ?[]const u8,

    /// The AI Prompt identifier used by the Case Summarization AI Agent.
    case_summarization_ai_prompt_id: ?[]const u8,

    /// The locale setting for the Case Summarization AI Agent.
    locale: ?[]const u8,

    pub const json_field_names = .{
        .case_summarization_ai_guardrail_id = "caseSummarizationAIGuardrailId",
        .case_summarization_ai_prompt_id = "caseSummarizationAIPromptId",
        .locale = "locale",
    };
};
