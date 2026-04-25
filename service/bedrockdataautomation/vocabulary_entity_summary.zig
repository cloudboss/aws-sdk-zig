const Language = @import("language.zig").Language;

/// Summary of a Vocabulary entity
pub const VocabularyEntitySummary = struct {
    description: ?[]const u8 = null,

    entity_id: ?[]const u8 = null,

    language: ?Language = null,

    last_modified_time: ?i64 = null,

    /// num of phrases in the entity
    num_of_phrases: ?i32 = null,

    pub const json_field_names = .{
        .description = "description",
        .entity_id = "entityId",
        .language = "language",
        .last_modified_time = "lastModifiedTime",
        .num_of_phrases = "numOfPhrases",
    };
};
