/// The template for the prompt that's sent to the model for response
/// generation.
pub const PromptTemplate = struct {
    /// The template for the prompt that's sent to the model for response
    /// generation. You can include prompt placeholders, which become replaced
    /// before the prompt is sent to the model to provide instructions and context
    /// to the model. In addition, you can include XML tags to delineate meaningful
    /// sections of the prompt template.
    ///
    /// For more information, see [Knowledge base prompt
    /// template](https://docs.aws.amazon.com/bedrock/latest/userguide/kb-test-config.html) and [Use XML tags with Anthropic Claude models](https://docs.anthropic.com/en/docs/build-with-claude/prompt-engineering/use-xml-tags).
    text_prompt_template: ?[]const u8,

    pub const json_field_names = .{
        .text_prompt_template = "textPromptTemplate",
    };
};
