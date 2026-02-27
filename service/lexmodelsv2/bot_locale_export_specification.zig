/// Provides the bot locale parameters required for exporting a bot
/// locale.
pub const BotLocaleExportSpecification = struct {
    /// The identifier of the bot to create the locale for.
    bot_id: []const u8,

    /// The version of the bot to export.
    bot_version: []const u8,

    /// The identifier of the language and locale to export. The string must
    /// match one of the locales in the bot.
    locale_id: []const u8,

    pub const json_field_names = .{
        .bot_id = "botId",
        .bot_version = "botVersion",
        .locale_id = "localeId",
    };
};
