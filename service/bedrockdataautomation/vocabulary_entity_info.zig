const Language = @import("language.zig").Language;
const Phrase = @import("phrase.zig").Phrase;

/// Vocabulary entity info with detailed information
pub const VocabularyEntityInfo = struct {
    description: ?[]const u8 = null,

    entity_id: ?[]const u8 = null,

    language: Language,

    phrases: []const Phrase,

    pub const json_field_names = .{
        .description = "description",
        .entity_id = "entityId",
        .language = "language",
        .phrases = "phrases",
    };
};
