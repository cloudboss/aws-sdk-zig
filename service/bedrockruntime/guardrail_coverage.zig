const GuardrailImageCoverage = @import("guardrail_image_coverage.zig").GuardrailImageCoverage;
const GuardrailTextCharactersCoverage = @import("guardrail_text_characters_coverage.zig").GuardrailTextCharactersCoverage;

/// The action of the guardrail coverage details.
pub const GuardrailCoverage = struct {
    /// The guardrail coverage for images (the number of images that guardrails
    /// guarded).
    images: ?GuardrailImageCoverage,

    /// The text characters of the guardrail coverage details.
    text_characters: ?GuardrailTextCharactersCoverage,

    pub const json_field_names = .{
        .images = "images",
        .text_characters = "textCharacters",
    };
};
