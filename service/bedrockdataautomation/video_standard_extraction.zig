const VideoBoundingBox = @import("video_bounding_box.zig").VideoBoundingBox;
const VideoExtractionCategory = @import("video_extraction_category.zig").VideoExtractionCategory;

/// Standard Extraction Configuration of Video
pub const VideoStandardExtraction = struct {
    bounding_box: VideoBoundingBox,

    category: VideoExtractionCategory,

    pub const json_field_names = .{
        .bounding_box = "boundingBox",
        .category = "category",
    };
};
