const TextFullAIPromptEditTemplateConfiguration = @import("text_full_ai_prompt_edit_template_configuration.zig").TextFullAIPromptEditTemplateConfiguration;

/// A typed union that specifies the configuration for a prompt template based
/// on its type.
pub const AIPromptTemplateConfiguration = union(enum) {
    /// The configuration for a prompt template that supports full textual prompt
    /// configuration using a YAML prompt.
    text_full_ai_prompt_edit_template_configuration: ?TextFullAIPromptEditTemplateConfiguration,

    pub const json_field_names = .{
        .text_full_ai_prompt_edit_template_configuration = "textFullAIPromptEditTemplateConfiguration",
    };
};
