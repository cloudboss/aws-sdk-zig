/// Provides the parameters required for importing a custom vocabulary.
pub const CustomVocabularyImportSpecification = struct {
    /// The identifier of the bot to import the custom vocabulary to.
    bot_id: []const u8,

    /// The version of the bot to import the custom vocabulary to.
    bot_version: []const u8,

    /// The identifier of the local to import the custom vocabulary to. The value
    /// must
    /// be `en_GB`.
    locale_id: []const u8,

    pub const json_field_names = .{
        .bot_id = "botId",
        .bot_version = "botVersion",
        .locale_id = "localeId",
    };
};
