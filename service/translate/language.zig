/// A supported language.
pub const Language = struct {
    /// Language code for the supported language.
    language_code: []const u8,

    /// Language name of the supported language.
    language_name: []const u8,

    pub const json_field_names = .{
        .language_code = "LanguageCode",
        .language_name = "LanguageName",
    };
};
