/// The language configuration for conversational analytics.
pub const LanguageConfiguration = struct {
    /// The language locale setting for conversational analytics.
    language_locale: ?[]const u8 = null,

    pub const json_field_names = .{
        .language_locale = "LanguageLocale",
    };
};
