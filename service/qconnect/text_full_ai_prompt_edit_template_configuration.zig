/// The configuration for a prompt template that supports full textual prompt
/// configuration using a YAML prompt.
pub const TextFullAIPromptEditTemplateConfiguration = struct {
    /// The YAML text for the AI Prompt template.
    text: []const u8,

    pub const json_field_names = .{
        .text = "text",
    };
};
