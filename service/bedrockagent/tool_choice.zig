const AnyToolChoice = @import("any_tool_choice.zig").AnyToolChoice;
const AutoToolChoice = @import("auto_tool_choice.zig").AutoToolChoice;
const SpecificToolChoice = @import("specific_tool_choice.zig").SpecificToolChoice;

/// Defines which tools the model should request when invoked. For more
/// information, see [Use a tool to complete an Amazon Bedrock model
/// response](https://docs.aws.amazon.com/bedrock/latest/userguide/tool-use.html).
pub const ToolChoice = union(enum) {
    /// Defines tools, at least one of which must be requested by the model. No text
    /// is generated but the results of tool use are sent back to the model to help
    /// generate a response.
    any: ?AnyToolChoice,
    /// Defines tools. The model automatically decides whether to call a tool or to
    /// generate text instead.
    auto: ?AutoToolChoice,
    /// Defines a specific tool that the model must request. No text is generated
    /// but the results of tool use are sent back to the model to help generate a
    /// response.
    tool: ?SpecificToolChoice,

    pub const json_field_names = .{
        .any = "any",
        .auto = "auto",
        .tool = "tool",
    };
};
