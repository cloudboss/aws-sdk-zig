/// Configuration settings for the EMAIL_OVERVIEW AI agent including prompt ID
/// and locale settings.
pub const EmailOverviewAIAgentConfiguration = struct {
    /// The ID of the System AI prompt used for generating structured email
    /// conversation summaries.
    email_overview_ai_prompt_id: ?[]const u8 = null,

    /// The locale setting for language-specific email overview processing (for
    /// example, en_US, es_ES).
    locale: ?[]const u8 = null,

    pub const json_field_names = .{
        .email_overview_ai_prompt_id = "emailOverviewAIPromptId",
        .locale = "locale",
    };
};
