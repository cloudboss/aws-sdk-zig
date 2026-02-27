const VocabularyLanguageCode = @import("vocabulary_language_code.zig").VocabularyLanguageCode;

/// Contains information about a default vocabulary.
pub const DefaultVocabulary = struct {
    /// The identifier of the Amazon Connect instance. You can [find the instance
    /// ID](https://docs.aws.amazon.com/connect/latest/adminguide/find-instance-arn.html) in the Amazon Resource Name (ARN) of the instance.
    instance_id: []const u8,

    /// The language code of the vocabulary entries. For a list of languages and
    /// their corresponding language codes, see
    /// [What is Amazon
    /// Transcribe?](https://docs.aws.amazon.com/transcribe/latest/dg/transcribe-whatis.html)
    language_code: VocabularyLanguageCode,

    /// The identifier of the custom vocabulary.
    vocabulary_id: []const u8,

    /// A unique name of the custom vocabulary.
    vocabulary_name: []const u8,

    pub const json_field_names = .{
        .instance_id = "InstanceId",
        .language_code = "LanguageCode",
        .vocabulary_id = "VocabularyId",
        .vocabulary_name = "VocabularyName",
    };
};
