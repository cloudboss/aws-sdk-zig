const HarnessReasoningContentBlock = @import("harness_reasoning_content_block.zig").HarnessReasoningContentBlock;
const HarnessToolResultBlock = @import("harness_tool_result_block.zig").HarnessToolResultBlock;
const HarnessToolUseBlock = @import("harness_tool_use_block.zig").HarnessToolUseBlock;

/// A content block within a message.
pub const HarnessContentBlock = union(enum) {
    /// Model reasoning content.
    reasoning_content: ?HarnessReasoningContentBlock,
    /// Text content.
    text: ?[]const u8,
    /// A tool execution result.
    tool_result: ?HarnessToolResultBlock,
    /// A tool use request from the model.
    tool_use: ?HarnessToolUseBlock,

    pub const json_field_names = .{
        .reasoning_content = "reasoningContent",
        .text = "text",
        .tool_result = "toolResult",
        .tool_use = "toolUse",
    };
};
