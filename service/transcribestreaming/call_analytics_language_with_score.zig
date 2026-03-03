const CallAnalyticsLanguageCode = @import("call_analytics_language_code.zig").CallAnalyticsLanguageCode;

/// The language code that represents the language identified in your audio,
/// including the associated
/// confidence score.
pub const CallAnalyticsLanguageWithScore = struct {
    /// The language code of the identified language.
    language_code: ?CallAnalyticsLanguageCode = null,

    /// The confidence score associated with the identified language code.
    /// Confidence scores are values between zero and one; larger values indicate a
    /// higher confidence in the identified language.
    score: f64 = 0,

    pub const json_field_names = .{
        .language_code = "LanguageCode",
        .score = "Score",
    };
};
