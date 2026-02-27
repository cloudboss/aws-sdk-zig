const ToolUseType = @import("tool_use_type.zig").ToolUseType;

/// The start of a tool use block. For more information, see [Call a tool with
/// the Converse
/// API](https://docs.aws.amazon.com/bedrock/latest/userguide/tool-use.html) in
/// the Amazon Bedrock User Guide.
pub const ToolUseBlockStart = struct {
    /// The name of the tool that the model is requesting to use.
    name: []const u8,

    /// The ID for the tool request.
    tool_use_id: []const u8,

    /// The type for the tool request.
    @"type": ?ToolUseType,

    pub const json_field_names = .{
        .name = "name",
        .tool_use_id = "toolUseId",
        .@"type" = "type",
    };
};
