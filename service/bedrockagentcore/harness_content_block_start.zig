const HarnessToolResultBlockStart = @import("harness_tool_result_block_start.zig").HarnessToolResultBlockStart;
const HarnessToolUseBlockStart = @import("harness_tool_use_block_start.zig").HarnessToolUseBlockStart;

/// The start payload for a content block.
pub const HarnessContentBlockStart = union(enum) {
    /// Start of a tool result content block.
    tool_result: ?HarnessToolResultBlockStart,
    /// Start of a tool use content block.
    tool_use: ?HarnessToolUseBlockStart,

    pub const json_field_names = .{
        .tool_result = "toolResult",
        .tool_use = "toolUse",
    };
};
