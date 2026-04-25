const HarnessReasoningContentBlockDelta = @import("harness_reasoning_content_block_delta.zig").HarnessReasoningContentBlockDelta;
const HarnessToolResultBlockDelta = @import("harness_tool_result_block_delta.zig").HarnessToolResultBlockDelta;
const HarnessToolUseBlockDelta = @import("harness_tool_use_block_delta.zig").HarnessToolUseBlockDelta;

/// A delta update to a content block.
pub const HarnessContentBlockDelta = union(enum) {
    /// A reasoning content delta.
    reasoning_content: ?HarnessReasoningContentBlockDelta,
    /// A text delta.
    text: ?[]const u8,
    /// A tool result delta.
    tool_result: ?[]const HarnessToolResultBlockDelta,
    /// A tool use input delta.
    tool_use: ?HarnessToolUseBlockDelta,

    pub const json_field_names = .{
        .reasoning_content = "reasoningContent",
        .text = "text",
        .tool_result = "toolResult",
        .tool_use = "toolUse",
    };
};
