const AssociationConfiguration = @import("association_configuration.zig").AssociationConfiguration;

/// Configuration settings for the EMAIL_RESPONSE AI agent including prompts,
/// locale, and knowledge base associations.
pub const EmailResponseAIAgentConfiguration = struct {
    /// Configuration settings for knowledge base associations used by the email
    /// response agent.
    association_configurations: ?[]const AssociationConfiguration,

    /// The ID of the System AI prompt used for reformulating email queries to
    /// optimize knowledge base search for response generation.
    email_query_reformulation_ai_prompt_id: ?[]const u8,

    /// The ID of the System AI prompt used for generating professional email
    /// responses based on knowledge base content.
    email_response_ai_prompt_id: ?[]const u8,

    /// The locale setting for language-specific email response generation (for
    /// example, en_US, es_ES).
    locale: ?[]const u8,

    pub const json_field_names = .{
        .association_configurations = "associationConfigurations",
        .email_query_reformulation_ai_prompt_id = "emailQueryReformulationAIPromptId",
        .email_response_ai_prompt_id = "emailResponseAIPromptId",
        .locale = "locale",
    };
};
