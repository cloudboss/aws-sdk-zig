const GuardrailConverseImageFormat = @import("guardrail_converse_image_format.zig").GuardrailConverseImageFormat;
const GuardrailConverseImageSource = @import("guardrail_converse_image_source.zig").GuardrailConverseImageSource;

/// An image block that contains images that you want to assess with a
/// guardrail.
pub const GuardrailConverseImageBlock = struct {
    /// The format details for the image type of the guardrail converse image block.
    format: GuardrailConverseImageFormat,

    /// The image source (image bytes) of the guardrail converse image block.
    source: GuardrailConverseImageSource,

    pub const json_field_names = .{
        .format = "format",
        .source = "source",
    };
};
