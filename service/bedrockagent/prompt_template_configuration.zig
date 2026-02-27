const ChatPromptTemplateConfiguration = @import("chat_prompt_template_configuration.zig").ChatPromptTemplateConfiguration;
const TextPromptTemplateConfiguration = @import("text_prompt_template_configuration.zig").TextPromptTemplateConfiguration;

/// Contains the message for a prompt. For more information, see [Construct and
/// store reusable prompts with Prompt management in Amazon
/// Bedrock](https://docs.aws.amazon.com/bedrock/latest/userguide/prompt-management.html).
pub const PromptTemplateConfiguration = union(enum) {
    /// Contains configurations to use the prompt in a conversational format.
    chat: ?ChatPromptTemplateConfiguration,
    /// Contains configurations for the text in a message for a prompt.
    text: ?TextPromptTemplateConfiguration,

    pub const json_field_names = .{
        .chat = "chat",
        .text = "text",
    };
};
