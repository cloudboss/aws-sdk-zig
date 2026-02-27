const ImageBlock = @import("image_block.zig").ImageBlock;

/// A block of content that you pass to, or receive from, a Amazon Bedrock
/// session in an invocation step. You pass the content to a session in the
/// `payLoad` of the
/// [PutInvocationStep](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent-runtime_PutInvocationStep.html) API operation. You retrieve the content with the [GetInvocationStep](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent-runtime_GetInvocationStep.html) API operation.
///
/// For more information about sessions, see [Store and retrieve conversation
/// history and context with Amazon Bedrock
/// sessions](https://docs.aws.amazon.com/bedrock/latest/userguide/sessions.html).
pub const BedrockSessionContentBlock = union(enum) {
    /// The image in the invocation step.
    image: ?ImageBlock,
    /// The text in the invocation step.
    text: ?[]const u8,

    pub const json_field_names = .{
        .image = "image",
        .text = "text",
    };
};
