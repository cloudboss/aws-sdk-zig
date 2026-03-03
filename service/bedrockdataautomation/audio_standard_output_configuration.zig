const AudioStandardExtraction = @import("audio_standard_extraction.zig").AudioStandardExtraction;
const AudioStandardGenerativeField = @import("audio_standard_generative_field.zig").AudioStandardGenerativeField;

/// Standard Output Configuration of Audio
pub const AudioStandardOutputConfiguration = struct {
    extraction: ?AudioStandardExtraction = null,

    generative_field: ?AudioStandardGenerativeField = null,

    pub const json_field_names = .{
        .extraction = "extraction",
        .generative_field = "generativeField",
    };
};
