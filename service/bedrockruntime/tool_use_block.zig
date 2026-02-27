const ToolUseType = @import("tool_use_type.zig").ToolUseType;

/// A tool use content block. Contains information about a tool that the model
/// is requesting be run., The model uses the result from the tool to generate a
/// response. For more information, see [Call a tool with the Converse
/// API](https://docs.aws.amazon.com/bedrock/latest/userguide/tool-use.html) in
/// the Amazon Bedrock User Guide.
pub const ToolUseBlock = struct {
    /// The input to pass to the tool.
    input: []const u8,

    /// The name of the tool that the model wants to use.
    name: []const u8,

    /// The ID for the tool request.
    tool_use_id: []const u8,

    /// The type for the tool request.
    @"type": ?ToolUseType,

    pub const json_field_names = .{
        .input = "input",
        .name = "name",
        .tool_use_id = "toolUseId",
        .@"type" = "type",
    };
};
