const BotLocaleStatus = @import("bot_locale_status.zig").BotLocaleStatus;

/// Summary information about bot locales returned by the
/// [ListBotLocales](https://docs.aws.amazon.com/lexv2/latest/APIReference/API_ListBotLocales.html) operation.
pub const BotLocaleSummary = struct {
    /// The current status of the bot locale. When the status is
    /// `Built` the locale is ready for use.
    bot_locale_status: ?BotLocaleStatus = null,

    /// The description of the bot locale.
    description: ?[]const u8 = null,

    /// A timestamp of the date and time that the bot locale was last
    /// built.
    last_build_submitted_date_time: ?i64 = null,

    /// A timestamp of the date and time that the bot locale was last
    /// updated.
    last_updated_date_time: ?i64 = null,

    /// The language and locale of the bot locale.
    locale_id: ?[]const u8 = null,

    /// The name of the bot locale.
    locale_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .bot_locale_status = "botLocaleStatus",
        .description = "description",
        .last_build_submitted_date_time = "lastBuildSubmittedDateTime",
        .last_updated_date_time = "lastUpdatedDateTime",
        .locale_id = "localeId",
        .locale_name = "localeName",
    };
};
