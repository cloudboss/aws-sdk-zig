const GuardrailConverseImageBlock = @import("guardrail_converse_image_block.zig").GuardrailConverseImageBlock;
const GuardrailConverseTextBlock = @import("guardrail_converse_text_block.zig").GuardrailConverseTextBlock;

/// A content block for selective guarding with the
/// [Converse](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_runtime_Converse.html) or [ConverseStream](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_runtime_ConverseStream.html) API operations.
pub const GuardrailConverseContentBlock = union(enum) {
    /// Image within converse content block to be evaluated by the guardrail.
    image: ?GuardrailConverseImageBlock,
    /// The text to guard.
    text: ?GuardrailConverseTextBlock,

    pub const json_field_names = .{
        .image = "image",
        .text = "text",
    };
};
