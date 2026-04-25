const VocabularyEntityInfo = @import("vocabulary_entity_info.zig").VocabularyEntityInfo;

/// Input configuration for upserting data in a
/// DataAutomationLibraryIngestionJob
pub const UpsertEntityInfo = union(enum) {
    vocabulary: ?VocabularyEntityInfo,

    pub const json_field_names = .{
        .vocabulary = "vocabulary",
    };
};
