/// Data about the result of tool usage.
pub const ToolUseResultData = struct {
    /// The input schema for the tool use result.
    input_schema: ?[]const u8 = null,

    /// The name of the tool that was used.
    tool_name: []const u8,

    /// The result of the tool usage.
    tool_result: []const u8,

    /// The identifier of the tool use instance.
    tool_use_id: []const u8,

    pub const json_field_names = .{
        .input_schema = "inputSchema",
        .tool_name = "toolName",
        .tool_result = "toolResult",
        .tool_use_id = "toolUseId",
    };
};
