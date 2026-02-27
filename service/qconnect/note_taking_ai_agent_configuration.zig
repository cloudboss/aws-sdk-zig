/// The configuration for AI Agents of type `NOTE_TAKING`.
pub const NoteTakingAIAgentConfiguration = struct {
    /// The locale setting for language-specific case summarization generation (for
    /// example, en_US, es_ES).
    locale: ?[]const u8,

    /// The AI Guardrail identifier used by the Note Taking AI Agent.
    note_taking_ai_guardrail_id: ?[]const u8,

    /// The AI Prompt identifier used by the Note Taking AI Agent.
    note_taking_ai_prompt_id: ?[]const u8,

    pub const json_field_names = .{
        .locale = "locale",
        .note_taking_ai_guardrail_id = "noteTakingAIGuardrailId",
        .note_taking_ai_prompt_id = "noteTakingAIPromptId",
    };
};
