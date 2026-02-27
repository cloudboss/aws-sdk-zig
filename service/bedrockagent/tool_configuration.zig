const ToolChoice = @import("tool_choice.zig").ToolChoice;
const Tool = @import("tool.zig").Tool;

/// Configuration information for the tools that the model can use when
/// generating a response. For more information, see [Use a tool to complete an
/// Amazon Bedrock model
/// response](https://docs.aws.amazon.com/bedrock/latest/userguide/tool-use.html).
pub const ToolConfiguration = struct {
    /// Defines which tools the model should request when invoked.
    tool_choice: ?ToolChoice,

    /// An array of tools to pass to a model.
    tools: []const Tool,

    pub const json_field_names = .{
        .tool_choice = "toolChoice",
        .tools = "tools",
    };
};
