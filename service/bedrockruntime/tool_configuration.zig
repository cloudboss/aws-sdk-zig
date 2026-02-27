const ToolChoice = @import("tool_choice.zig").ToolChoice;
const Tool = @import("tool.zig").Tool;

/// Configuration information for the tools that you pass to a model. For more
/// information, see [Tool use (function
/// calling)](https://docs.aws.amazon.com/bedrock/latest/userguide/tool-use.html) in the Amazon Bedrock User Guide.
pub const ToolConfiguration = struct {
    /// If supported by model, forces the model to request a tool.
    tool_choice: ?ToolChoice,

    /// An array of tools that you want to pass to a model.
    tools: []const Tool,

    pub const json_field_names = .{
        .tool_choice = "toolChoice",
        .tools = "tools",
    };
};
