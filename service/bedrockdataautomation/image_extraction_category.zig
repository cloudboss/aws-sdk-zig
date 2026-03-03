const State = @import("state.zig").State;
const ImageExtractionCategoryType = @import("image_extraction_category_type.zig").ImageExtractionCategoryType;

/// Category of Image Extraction
pub const ImageExtractionCategory = struct {
    state: State,

    types: ?[]const ImageExtractionCategoryType = null,

    pub const json_field_names = .{
        .state = "state",
        .types = "types",
    };
};
