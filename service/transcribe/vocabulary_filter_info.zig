const LanguageCode = @import("language_code.zig").LanguageCode;

/// Provides information about a custom vocabulary filter, including the
/// language of the
/// filter, when it was last modified, and its name.
pub const VocabularyFilterInfo = struct {
    /// The language code that represents the language of the entries in your
    /// vocabulary
    /// filter. Each custom vocabulary filter must contain terms in only one
    /// language.
    ///
    /// A custom vocabulary filter can only be used to transcribe files in the same
    /// language
    /// as the filter. For example, if you create a custom vocabulary filter using
    /// US English
    /// (`en-US`), you can only apply this filter to files that contain English
    /// audio.
    ///
    /// For a list of supported languages and their associated language codes, refer
    /// to the
    /// [Supported
    /// languages](https://docs.aws.amazon.com/transcribe/latest/dg/supported-languages.html) table.
    language_code: ?LanguageCode = null,

    /// The date and time the specified custom vocabulary filter was last modified.
    ///
    /// Timestamps are in the format `YYYY-MM-DD'T'HH:MM:SS.SSSSSS-UTC`. For
    /// example, `2022-05-04T12:32:58.761000-07:00` represents 12:32 PM UTC-7 on May
    /// 4, 2022.
    last_modified_time: ?i64 = null,

    /// A unique name, chosen by you, for your custom vocabulary filter. This name
    /// is case
    /// sensitive, cannot contain spaces, and must be unique within an Amazon Web
    /// Services account.
    vocabulary_filter_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .language_code = "LanguageCode",
        .last_modified_time = "LastModifiedTime",
        .vocabulary_filter_name = "VocabularyFilterName",
    };
};
