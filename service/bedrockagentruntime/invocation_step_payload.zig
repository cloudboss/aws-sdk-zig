const BedrockSessionContentBlock = @import("bedrock_session_content_block.zig").BedrockSessionContentBlock;

/// Payload content, such as text and images, for the invocation step.
pub const InvocationStepPayload = union(enum) {
    /// The content for the invocation step.
    content_blocks: ?[]const BedrockSessionContentBlock,

    pub const json_field_names = .{
        .content_blocks = "contentBlocks",
    };
};
