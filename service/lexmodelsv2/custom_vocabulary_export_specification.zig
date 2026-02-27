/// Provides the parameters required for exporting a custom vocabulary.
pub const CustomVocabularyExportSpecification = struct {
    /// The identifier of the bot that contains the custom vocabulary to export.
    bot_id: []const u8,

    /// The version of the bot that contains the custom vocabulary to export.
    bot_version: []const u8,

    /// The locale of the bot that contains the custom vocabulary to export.
    locale_id: []const u8,

    pub const json_field_names = .{
        .bot_id = "botId",
        .bot_version = "botVersion",
        .locale_id = "localeId",
    };
};
