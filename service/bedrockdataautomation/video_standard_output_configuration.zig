const VideoStandardExtraction = @import("video_standard_extraction.zig").VideoStandardExtraction;
const VideoStandardGenerativeField = @import("video_standard_generative_field.zig").VideoStandardGenerativeField;

/// Standard Output Configuration of Video
pub const VideoStandardOutputConfiguration = struct {
    extraction: ?VideoStandardExtraction = null,

    generative_field: ?VideoStandardGenerativeField = null,

    pub const json_field_names = .{
        .extraction = "extraction",
        .generative_field = "generativeField",
    };
};
