const ToolResultContentBlock = @import("tool_result_content_block.zig").ToolResultContentBlock;
const ToolResultStatus = @import("tool_result_status.zig").ToolResultStatus;

/// A tool result block that contains the results for a tool request that the
/// model previously made. For more information, see [Call a tool with the
/// Converse
/// API](https://docs.aws.amazon.com/bedrock/latest/userguide/tool-use.html) in
/// the Amazon Bedrock User Guide.
pub const ToolResultBlock = struct {
    /// The content for tool result content block.
    content: []const ToolResultContentBlock,

    /// The status for the tool result content block.
    ///
    /// This field is only supported by Amazon Nova and Anthropic Claude 3 and 4
    /// models.
    status: ?ToolResultStatus,

    /// The ID of the tool request that this is the result for.
    tool_use_id: []const u8,

    /// The type for the tool result content block.
    type: ?[]const u8,

    pub const json_field_names = .{
        .content = "content",
        .status = "status",
        .tool_use_id = "toolUseId",
        .type = "type",
    };
};
