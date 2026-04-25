const HarnessToolResultContentBlock = @import("harness_tool_result_content_block.zig").HarnessToolResultContentBlock;
const HarnessToolUseStatus = @import("harness_tool_use_status.zig").HarnessToolUseStatus;
const HarnessToolUseType = @import("harness_tool_use_type.zig").HarnessToolUseType;

/// The result of a tool execution.
pub const HarnessToolResultBlock = struct {
    /// The content of the tool result.
    content: []const HarnessToolResultContentBlock,

    /// The status of the tool execution.
    status: ?HarnessToolUseStatus = null,

    /// The tool use ID that this result corresponds to.
    tool_use_id: []const u8,

    /// The type of tool use that produced this result.
    @"type": ?HarnessToolUseType = null,

    pub const json_field_names = .{
        .content = "content",
        .status = "status",
        .tool_use_id = "toolUseId",
        .@"type" = "type",
    };
};
