const Language = @import("language.zig").Language;
const Phrase = @import("phrase.zig").Phrase;

/// Vocabulary entity with detailed information
pub const VocabularyEntity = struct {
    description: ?[]const u8 = null,

    entity_id: ?[]const u8 = null,

    language: ?Language = null,

    last_modified_time: ?i64 = null,

    phrases: ?[]const Phrase = null,

    pub const json_field_names = .{
        .description = "description",
        .entity_id = "entityId",
        .language = "language",
        .last_modified_time = "lastModifiedTime",
        .phrases = "phrases",
    };
};
