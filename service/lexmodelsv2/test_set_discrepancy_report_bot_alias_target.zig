/// Contains information about the bot alias used for the
/// test set discrepancy report.
pub const TestSetDiscrepancyReportBotAliasTarget = struct {
    /// The unique identifier for the bot associated with the bot alias.
    bot_alias_id: []const u8,

    /// The unique identifier for the bot alias.
    bot_id: []const u8,

    /// The unique identifier of the locale associated with the bot alias.
    locale_id: []const u8,

    pub const json_field_names = .{
        .bot_alias_id = "botAliasId",
        .bot_id = "botId",
        .locale_id = "localeId",
    };
};
