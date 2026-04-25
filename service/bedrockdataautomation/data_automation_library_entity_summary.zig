const VocabularyEntitySummary = @import("vocabulary_entity_summary.zig").VocabularyEntitySummary;

/// Summarized information about an entity
pub const DataAutomationLibraryEntitySummary = union(enum) {
    vocabulary: ?VocabularyEntitySummary,

    pub const json_field_names = .{
        .vocabulary = "vocabulary",
    };
};
