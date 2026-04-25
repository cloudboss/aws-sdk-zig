const HarnessToolUseType = @import("harness_tool_use_type.zig").HarnessToolUseType;

/// Start payload for a tool use content block.
pub const HarnessToolUseBlockStart = struct {
    /// The name of the tool being called.
    name: []const u8,

    /// The name of the MCP server providing this tool.
    server_name: ?[]const u8 = null,

    /// The unique ID of this tool use.
    tool_use_id: []const u8,

    /// The type of tool use.
    @"type": ?HarnessToolUseType = null,

    pub const json_field_names = .{
        .name = "name",
        .server_name = "serverName",
        .tool_use_id = "toolUseId",
        .@"type" = "type",
    };
};
