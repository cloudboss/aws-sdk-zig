const ReasoningTextBlock = @import("reasoning_text_block.zig").ReasoningTextBlock;

/// Contains content regarding the reasoning that the foundation model made with
/// respect to the content in the content block. Reasoning refers to a Chain of
/// Thought (CoT) that the model generates to enhance the accuracy of its final
/// response.
pub const ReasoningContentBlock = union(enum) {
    /// Contains information about the reasoning that the model used to return the
    /// content in the content block.
    reasoning_text: ?ReasoningTextBlock,
    /// The content in the reasoning that was encrypted by the model provider for
    /// trust and safety reasons.
    redacted_content: ?[]const u8,

    pub const json_field_names = .{
        .reasoning_text = "reasoningText",
        .redacted_content = "redactedContent",
    };
};
