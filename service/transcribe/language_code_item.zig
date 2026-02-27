const LanguageCode = @import("language_code.zig").LanguageCode;

/// Provides information on the speech contained in a discreet utterance when
/// multi-language identification is enabled in your request. This utterance
/// represents a
/// block of speech consisting of one language, preceded or followed by a block
/// of speech in
/// a different language.
pub const LanguageCodeItem = struct {
    /// Provides the total time, in seconds, each identified language is spoken in
    /// your
    /// media.
    duration_in_seconds: ?f32,

    /// Provides the language code for each language identified in your media.
    language_code: ?LanguageCode,

    pub const json_field_names = .{
        .duration_in_seconds = "DurationInSeconds",
        .language_code = "LanguageCode",
    };
};
