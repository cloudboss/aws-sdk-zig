const LanguageCode = @import("language_code.zig").LanguageCode;

/// Contains metadata describing the lexicon such as the number of
/// lexemes, language code, and so on. For more information, see [Managing
/// Lexicons](https://docs.aws.amazon.com/polly/latest/dg/managing-lexicons.html).
pub const LexiconAttributes = struct {
    /// Phonetic alphabet used in the lexicon. Valid values are
    /// `ipa` and `x-sampa`.
    alphabet: ?[]const u8 = null,

    /// Language code that the lexicon applies to. A lexicon with a
    /// language code such as "en" would be applied to all English languages
    /// (en-GB, en-US, en-AUS, en-WLS, and so on.
    language_code: ?LanguageCode = null,

    /// Date lexicon was last modified (a timestamp value).
    last_modified: ?i64 = null,

    /// Number of lexemes in the lexicon.
    lexemes_count: i32 = 0,

    /// Amazon Resource Name (ARN) of the lexicon.
    lexicon_arn: ?[]const u8 = null,

    /// Total size of the lexicon, in characters.
    size: i32 = 0,

    pub const json_field_names = .{
        .alphabet = "Alphabet",
        .language_code = "LanguageCode",
        .last_modified = "LastModified",
        .lexemes_count = "LexemesCount",
        .lexicon_arn = "LexiconArn",
        .size = "Size",
    };
};
