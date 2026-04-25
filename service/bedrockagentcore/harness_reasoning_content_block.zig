const HarnessReasoningTextBlock = @import("harness_reasoning_text_block.zig").HarnessReasoningTextBlock;

/// Reasoning content from the model.
pub const HarnessReasoningContentBlock = union(enum) {
    /// The reasoning text.
    reasoning_text: ?HarnessReasoningTextBlock,
    /// Redacted reasoning content.
    redacted_content: ?[]const u8,

    pub const json_field_names = .{
        .reasoning_text = "reasoningText",
        .redacted_content = "redactedContent",
    };
};
