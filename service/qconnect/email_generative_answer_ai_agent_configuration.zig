const AssociationConfiguration = @import("association_configuration.zig").AssociationConfiguration;

/// Configuration settings for the EMAIL_GENERATIVE_ANSWER AI agent including
/// prompts, locale, and knowledge base associations.
pub const EmailGenerativeAnswerAIAgentConfiguration = struct {
    /// Configuration settings for knowledge base associations used by the email
    /// generative answer agent.
    association_configurations: ?[]const AssociationConfiguration,

    /// The ID of the System AI prompt used for generating comprehensive
    /// knowledge-based answers from email queries.
    email_generative_answer_ai_prompt_id: ?[]const u8,

    /// The ID of the System AI prompt used for reformulating email queries to
    /// optimize knowledge base search results.
    email_query_reformulation_ai_prompt_id: ?[]const u8,

    /// The locale setting for language-specific email processing and response
    /// generation (for example, en_US, es_ES).
    locale: ?[]const u8,

    pub const json_field_names = .{
        .association_configurations = "associationConfigurations",
        .email_generative_answer_ai_prompt_id = "emailGenerativeAnswerAIPromptId",
        .email_query_reformulation_ai_prompt_id = "emailQueryReformulationAIPromptId",
        .locale = "locale",
    };
};
