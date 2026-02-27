const AssociationConfiguration = @import("association_configuration.zig").AssociationConfiguration;

/// The configuration for the `MANUAL_SEARCH` AI Agent type.
pub const ManualSearchAIAgentConfiguration = struct {
    /// The AI Guardrail identifier for the Answer Generation guardrail used by the
    /// MANUAL_SEARCH AI Agent.
    answer_generation_ai_guardrail_id: ?[]const u8,

    /// The AI Prompt identifier for the Answer Generation prompt used by the
    /// MANUAL_SEARCH AI Agent.
    answer_generation_ai_prompt_id: ?[]const u8,

    /// The association configurations for overriding behavior on this AI Agent.
    association_configurations: ?[]const AssociationConfiguration,

    /// The locale to which specifies the language and region settings that
    /// determine the response language for
    /// [QueryAssistant](https://docs.aws.amazon.com/connect/latest/APIReference/API_amazon-q-connect_QueryAssistant.html).
    ///
    /// For more information on supported locales, see [Language support for Amazon
    /// Q in
    /// Connect](https://docs.aws.amazon.com/connect/latest/adminguide/supported-languages.html#qic-notes-languages).
    locale: ?[]const u8,

    pub const json_field_names = .{
        .answer_generation_ai_guardrail_id = "answerGenerationAIGuardrailId",
        .answer_generation_ai_prompt_id = "answerGenerationAIPromptId",
        .association_configurations = "associationConfigurations",
        .locale = "locale",
    };
};
