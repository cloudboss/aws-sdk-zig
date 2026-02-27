const aws = @import("aws");

const VocabularyLanguageCode = @import("vocabulary_language_code.zig").VocabularyLanguageCode;
const VocabularyState = @import("vocabulary_state.zig").VocabularyState;

/// Contains information about a custom vocabulary.
pub const Vocabulary = struct {
    /// The Amazon Resource Name (ARN) of the custom vocabulary.
    arn: []const u8,

    /// The content of the custom vocabulary in plain-text format with a table of
    /// values. Each row
    /// in the table represents a word or a phrase, described with `Phrase`, `IPA`,
    /// `SoundsLike`, and `DisplayAs` fields. Separate the fields with TAB
    /// characters. For more information, see [Create a custom
    /// vocabulary using a
    /// table](https://docs.aws.amazon.com/transcribe/latest/dg/custom-vocabulary.html#create-vocabulary-table).
    content: ?[]const u8,

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

    /// The tags used to organize, track, or control access for this resource. For
    /// example, { "Tags": {"key1":"value1", "key2":"value2"} }.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .arn = "Arn",
        .content = "Content",
        .failure_reason = "FailureReason",
        .id = "Id",
        .language_code = "LanguageCode",
        .last_modified_time = "LastModifiedTime",
        .name = "Name",
        .state = "State",
        .tags = "Tags",
    };
};
