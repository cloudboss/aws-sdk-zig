const ImageBoundingBox = @import("image_bounding_box.zig").ImageBoundingBox;
const ImageExtractionCategory = @import("image_extraction_category.zig").ImageExtractionCategory;

/// Standard Extraction Configuration of Image
pub const ImageStandardExtraction = struct {
    bounding_box: ImageBoundingBox,

    category: ImageExtractionCategory,

    pub const json_field_names = .{
        .bounding_box = "boundingBox",
        .category = "category",
    };
};
