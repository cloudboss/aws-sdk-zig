const State = @import("state.zig").State;
const VideoExtractionCategoryType = @import("video_extraction_category_type.zig").VideoExtractionCategoryType;

/// Category of Video Extraction
pub const VideoExtractionCategory = struct {
    state: State,

    types: ?[]const VideoExtractionCategoryType,

    pub const json_field_names = .{
        .state = "state",
        .types = "types",
    };
};
