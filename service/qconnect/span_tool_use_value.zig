/// Tool invocation message content
pub const SpanToolUseValue = struct {
    /// The tool input arguments
    arguments: []const u8,

    /// The tool name
    name: []const u8,

    /// Unique ID for this tool invocation
    tool_use_id: []const u8,

    pub const json_field_names = .{
        .arguments = "arguments",
        .name = "name",
        .tool_use_id = "toolUseId",
    };
};
