const AssociationConfiguration = @import("association_configuration.zig").AssociationConfiguration;

/// The configuration for the `ANSWER_RECOMMENDATION` AI Agent type.
pub const AnswerRecommendationAIAgentConfiguration = struct {
    /// The AI Guardrail identifier for the Answer Generation Guardrail used by the
    /// `ANSWER_RECOMMENDATION` AI Agent.
    answer_generation_ai_guardrail_id: ?[]const u8,

    /// The AI Prompt identifier for the Answer Generation prompt used by the
    /// `ANSWER_RECOMMENDATION` AI Agent.
    answer_generation_ai_prompt_id: ?[]const u8,

    /// The association configurations for overriding behavior on this AI Agent.
    association_configurations: ?[]const AssociationConfiguration,

    /// The AI Prompt identifier for the Intent Labeling prompt used by the
    /// `ANSWER_RECOMMENDATION` AI Agent.
    intent_labeling_generation_ai_prompt_id: ?[]const u8,

    /// The locale to which specifies the language and region settings that
    /// determine the response language for
    /// [QueryAssistant](https://docs.aws.amazon.com/connect/latest/APIReference/API_amazon-q-connect_QueryAssistant.html).
    ///
    /// For more information on supported locales, see [Language support for Amazon
    /// Q in
    /// Connect](https://docs.aws.amazon.com/connect/latest/adminguide/supported-languages.html#qic-notes-languages).
    locale: ?[]const u8,

    /// The AI Prompt identifier for the Query Reformulation prompt used by the
    /// `ANSWER_RECOMMENDATION` AI Agent.
    query_reformulation_ai_prompt_id: ?[]const u8,

    /// The suggested messages configuration for the Answer Recommendation AI Agent.
    suggested_messages: ?[]const []const u8,

    pub const json_field_names = .{
        .answer_generation_ai_guardrail_id = "answerGenerationAIGuardrailId",
        .answer_generation_ai_prompt_id = "answerGenerationAIPromptId",
        .association_configurations = "associationConfigurations",
        .intent_labeling_generation_ai_prompt_id = "intentLabelingGenerationAIPromptId",
        .locale = "locale",
        .query_reformulation_ai_prompt_id = "queryReformulationAIPromptId",
        .suggested_messages = "suggestedMessages",
    };
};
