const VocabularyEntity = @import("vocabulary_entity.zig").VocabularyEntity;

/// Detailed information about an entity
pub const EntityDetails = union(enum) {
    vocabulary: ?VocabularyEntity,

    pub const json_field_names = .{
        .vocabulary = "vocabulary",
    };
};
