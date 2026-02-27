const VocabularyLanguageCode = @import("vocabulary_language_code.zig").VocabularyLanguageCode;
const VocabularyState = @import("vocabulary_state.zig").VocabularyState;

/// Contains summary information about the custom vocabulary.
pub const VocabularySummary = struct {
    /// The Amazon Resource Name (ARN) of the custom vocabulary.
    arn: []const u8,

    /// The reason why the custom vocabulary was not created.
    failure_reason: ?[]const u8,

    /// The identifier of the custom vocabulary.
    id: []const u8,

    /// The language code of the vocabulary entries. For a list of languages and
    /// their corresponding language codes, see
    /// [What is Amazon
    /// Transcribe?](https://docs.aws.amazon.com/transcribe/latest/dg/transcribe-whatis.html)
    language_code: VocabularyLanguageCode,

    /// The timestamp when the custom vocabulary was last modified.
    last_modified_time: i64,

    /// A unique name of the custom vocabulary.
    name: []const u8,

    /// The current state of the custom vocabulary.
    state: VocabularyState,

    pub const json_field_names = .{
        .arn = "Arn",
        .failure_reason = "FailureReason",
        .id = "Id",
        .language_code = "LanguageCode",
        .last_modified_time = "LastModifiedTime",
        .name = "Name",
        .state = "State",
    };
};
