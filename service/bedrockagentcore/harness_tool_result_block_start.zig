const HarnessToolUseStatus = @import("harness_tool_use_status.zig").HarnessToolUseStatus;

/// Start payload for a tool result content block.
pub const HarnessToolResultBlockStart = struct {
    /// The status of the tool execution.
    status: ?HarnessToolUseStatus = null,

    /// The tool use ID that this result corresponds to.
    tool_use_id: []const u8,

    pub const json_field_names = .{
        .status = "status",
        .tool_use_id = "toolUseId",
    };
};
