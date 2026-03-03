const PromptInputVariable = @import("prompt_input_variable.zig").PromptInputVariable;
const Message = @import("message.zig").Message;
const SystemContentBlock = @import("system_content_block.zig").SystemContentBlock;
const ToolConfiguration = @import("tool_configuration.zig").ToolConfiguration;

/// Contains configurations to use a prompt in a conversational format. For more
/// information, see [Create a prompt using Prompt
/// management](https://docs.aws.amazon.com/bedrock/latest/userguide/prompt-management-create.html).
pub const ChatPromptTemplateConfiguration = struct {
    /// An array of the variables in the prompt template.
    input_variables: ?[]const PromptInputVariable = null,

    /// Contains messages in the chat for the prompt.
    messages: []const Message,

    /// Contains system prompts to provide context to the model or to describe how
    /// it should behave.
    system: ?[]const SystemContentBlock = null,

    /// Configuration information for the tools that the model can use when
    /// generating a response.
    tool_configuration: ?ToolConfiguration = null,

    pub const json_field_names = .{
        .input_variables = "inputVariables",
        .messages = "messages",
        .system = "system",
        .tool_configuration = "toolConfiguration",
    };
};
