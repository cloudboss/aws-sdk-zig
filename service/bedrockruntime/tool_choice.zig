const AnyToolChoice = @import("any_tool_choice.zig").AnyToolChoice;
const AutoToolChoice = @import("auto_tool_choice.zig").AutoToolChoice;
const SpecificToolChoice = @import("specific_tool_choice.zig").SpecificToolChoice;

/// Determines which tools the model should request in a call to `Converse` or
/// `ConverseStream`. For more information, see [Call a tool with the Converse
/// API](https://docs.aws.amazon.com/bedrock/latest/userguide/tool-use.html) in
/// the Amazon Bedrock User Guide.
pub const ToolChoice = union(enum) {
    /// The model must request at least one tool (no text is generated).
    any: ?AnyToolChoice,
    /// (Default). The Model automatically decides if a tool should be called or
    /// whether to generate text instead.
    auto: ?AutoToolChoice,
    /// The Model must request the specified tool. Only supported by Anthropic
    /// Claude 3 and Amazon Nova models.
    tool: ?SpecificToolChoice,

    pub const json_field_names = .{
        .any = "any",
        .auto = "auto",
        .tool = "tool",
    };
};
