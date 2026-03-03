const LanguageCode = @import("language_code.zig").LanguageCode;

/// The language code that represents the language identified in your audio,
/// including the associated
/// confidence score. If you enabled channel identification in your request and
/// each channel contained a
/// different language, you will have more than one `LanguageWithScore` result.
pub const LanguageWithScore = struct {
    /// The language code of the identified language.
    language_code: ?LanguageCode = null,

    /// The confidence score associated with the identified language code.
    /// Confidence scores are values
    /// between zero and one; larger values indicate a higher confidence in the
    /// identified language.
    score: f64 = 0,

    pub const json_field_names = .{
        .language_code = "LanguageCode",
        .score = "Score",
    };
};
