const State = @import("state.zig").State;
const AudioExtractionCategoryTypeConfiguration = @import("audio_extraction_category_type_configuration.zig").AudioExtractionCategoryTypeConfiguration;
const AudioExtractionCategoryType = @import("audio_extraction_category_type.zig").AudioExtractionCategoryType;

/// Category of Audio Extraction
pub const AudioExtractionCategory = struct {
    state: State,

    type_configuration: ?AudioExtractionCategoryTypeConfiguration = null,

    types: ?[]const AudioExtractionCategoryType = null,

    pub const json_field_names = .{
        .state = "state",
        .type_configuration = "typeConfiguration",
        .types = "types",
    };
};
