/// Provides a record of an event that affects a bot alias. For example,
/// when the version of a bot that the alias points to changes.
pub const BotAliasHistoryEvent = struct {
    /// The version of the bot that was used in the event.
    bot_version: ?[]const u8 = null,

    /// The date and time that the event ended.
    end_date: ?i64 = null,

    /// The date and time that the event started.
    start_date: ?i64 = null,

    pub const json_field_names = .{
        .bot_version = "botVersion",
        .end_date = "endDate",
        .start_date = "startDate",
    };
};
