const HarnessToolUseType = @import("harness_tool_use_type.zig").HarnessToolUseType;

/// A tool use request from the model.
pub const HarnessToolUseBlock = struct {
    /// The JSON input to pass to the tool.
    input: []const u8,

    /// The name of the tool to call.
    name: []const u8,

    /// The name of the MCP server providing this tool.
    server_name: ?[]const u8 = null,

    /// The unique ID of this tool use.
    tool_use_id: []const u8,

    /// The type of tool use.
    @"type": ?HarnessToolUseType = null,

    pub const json_field_names = .{
        .input = "input",
        .name = "name",
        .server_name = "serverName",
        .tool_use_id = "toolUseId",
        .@"type" = "type",
    };
};
