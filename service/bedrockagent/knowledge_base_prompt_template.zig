/// Defines a custom prompt template for orchestrating the retrieval and
/// generation process.
pub const KnowledgeBasePromptTemplate = struct {
    /// The text of the prompt template.
    text_prompt_template: ?[]const u8 = null,

    pub const json_field_names = .{
        .text_prompt_template = "textPromptTemplate",
    };
};
