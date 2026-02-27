const GuardrailImageBlock = @import("guardrail_image_block.zig").GuardrailImageBlock;
const GuardrailTextBlock = @import("guardrail_text_block.zig").GuardrailTextBlock;

/// The content block to be evaluated by the guardrail.
pub const GuardrailContentBlock = union(enum) {
    /// Image within guardrail content block to be evaluated by the guardrail.
    image: ?GuardrailImageBlock,
    /// Text within content block to be evaluated by the guardrail.
    text: ?GuardrailTextBlock,

    pub const json_field_names = .{
        .image = "image",
        .text = "text",
    };
};
