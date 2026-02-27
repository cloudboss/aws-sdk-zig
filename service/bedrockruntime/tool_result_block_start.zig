const ToolResultStatus = @import("tool_result_status.zig").ToolResultStatus;

/// The start of a tool result block. For more information, see [Call a tool
/// with the Converse
/// API](https://docs.aws.amazon.com/bedrock/latest/userguide/tool-use.html) in
/// the Amazon Bedrock User Guide.
pub const ToolResultBlockStart = struct {
    /// The status of the tool result block.
    status: ?ToolResultStatus,

    /// The ID of the tool that was used to generate this tool result block.
    tool_use_id: []const u8,

    /// The type for the tool that was used to generate this tool result block.
    @"type": ?[]const u8,

    pub const json_field_names = .{
        .status = "status",
        .tool_use_id = "toolUseId",
        .@"type" = "type",
    };
};
