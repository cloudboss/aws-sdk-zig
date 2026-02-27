/// A JSON-formatted object that contains the available ISO 639-1 language
/// `code`,
/// `language` name and langauge `display` value. The language code is what
/// should be used
/// in the CreateCase call.
pub const SupportedLanguage = struct {
    /// 2 digit ISO 639-1 code. e.g. `en`
    code: ?[]const u8,

    /// Language display value e.g. `ENGLISH`
    display: ?[]const u8,

    /// Full language description e.g. `ENGLISH`
    language: ?[]const u8,

    pub const json_field_names = .{
        .code = "code",
        .display = "display",
        .language = "language",
    };
};
