const LanguageCode = @import("language_code.zig").LanguageCode;
const VocabularyState = @import("vocabulary_state.zig").VocabularyState;

/// Provides information about a custom vocabulary, including the language of
/// the custom
/// vocabulary, when it was last modified, its name, and the processing state.
pub const VocabularyInfo = struct {
    /// The language code used to create your custom vocabulary. Each custom
    /// vocabulary must
    /// contain terms in only one language.
    ///
    /// A custom vocabulary can only be used to transcribe files in the same
    /// language as the
    /// custom vocabulary. For example, if you create a custom vocabulary using US
    /// English
    /// (`en-US`), you can only apply this custom vocabulary to files that
    /// contain English audio.
    language_code: ?LanguageCode = null,

    /// The date and time the specified custom vocabulary was last modified.
    ///
    /// Timestamps are in the format `YYYY-MM-DD'T'HH:MM:SS.SSSSSS-UTC`. For
    /// example, `2022-05-04T12:32:58.761000-07:00` represents 12:32 PM UTC-7 on May
    /// 4, 2022.
    last_modified_time: ?i64 = null,

    /// A unique name, chosen by you, for your custom vocabulary. This name is case
    /// sensitive,
    /// cannot contain spaces, and must be unique within an Amazon Web Services
    /// account.
    vocabulary_name: ?[]const u8 = null,

    /// The processing state of your custom vocabulary. If the state is `READY`,
    /// you can use the custom vocabulary in a `StartTranscriptionJob`
    /// request.
    vocabulary_state: ?VocabularyState = null,

    pub const json_field_names = .{
        .language_code = "LanguageCode",
        .last_modified_time = "LastModifiedTime",
        .vocabulary_name = "VocabularyName",
        .vocabulary_state = "VocabularyState",
    };
};
