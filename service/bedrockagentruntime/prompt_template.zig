/// Contains the template for the prompt that's sent to the model for response
/// generation. For more information, see [Knowledge base prompt
/// templates](https://docs.aws.amazon.com/bedrock/latest/userguide/kb-test-config.html#kb-test-config-sysprompt).
///
/// This data type is used in the following API operations:
///
/// * [RetrieveAndGenerate
///   request](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent-runtime_RetrieveAndGenerate.html#API_agent-runtime_RetrieveAndGenerate_RequestSyntax) – in the `filter` field
pub const PromptTemplate = struct {
    /// The template for the prompt that's sent to the model for response
    /// generation. You can include prompt placeholders, which become replaced
    /// before the prompt is sent to the model to provide instructions and context
    /// to the model. In addition, you can include XML tags to delineate meaningful
    /// sections of the prompt template.
    ///
    /// For more information, see the following resources:
    ///
    /// * [Knowledge base prompt
    ///   templates](https://docs.aws.amazon.com/bedrock/latest/userguide/kb-test-config.html#kb-test-config-sysprompt)
    /// * [Use XML tags with Anthropic Claude
    ///   models](https://docs.claude.com/en/docs/build-with-claude/prompt-engineering/use-xml-tags)
    text_prompt_template: ?[]const u8,

    pub const json_field_names = .{
        .text_prompt_template = "textPromptTemplate",
    };
};
