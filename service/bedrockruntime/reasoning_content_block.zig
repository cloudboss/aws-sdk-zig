const ReasoningTextBlock = @import("reasoning_text_block.zig").ReasoningTextBlock;

/// Contains content regarding the reasoning that is carried out by the model
/// with respect to the content in the content block. Reasoning refers to a
/// Chain of Thought (CoT) that the model generates to enhance the accuracy of
/// its final response.
pub const ReasoningContentBlock = union(enum) {
    /// The reasoning that the model used to return the output.
    reasoning_text: ?ReasoningTextBlock,
    /// The content in the reasoning that was encrypted by the model provider for
    /// safety reasons. The encryption doesn't affect the quality of responses.
    redacted_content: ?[]const u8,

    pub const json_field_names = .{
        .reasoning_text = "reasoningText",
        .redacted_content = "redactedContent",
    };
};
