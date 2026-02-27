const GuardrailImageFormat = @import("guardrail_image_format.zig").GuardrailImageFormat;
const GuardrailImageSource = @import("guardrail_image_source.zig").GuardrailImageSource;

/// Contain an image which user wants guarded. This block is accepted by the
/// guardrails independent API.
pub const GuardrailImageBlock = struct {
    /// The format details for the file type of the image blocked by the guardrail.
    format: GuardrailImageFormat,

    /// The image source (image bytes) details of the image blocked by the
    /// guardrail.
    source: GuardrailImageSource,

    pub const json_field_names = .{
        .format = "format",
        .source = "source",
    };
};
