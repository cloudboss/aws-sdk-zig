const AudioExtractionCategory = @import("audio_extraction_category.zig").AudioExtractionCategory;

/// Standard Extraction Configuration of Audio
pub const AudioStandardExtraction = struct {
    category: AudioExtractionCategory,

    pub const json_field_names = .{
        .category = "category",
    };
};
