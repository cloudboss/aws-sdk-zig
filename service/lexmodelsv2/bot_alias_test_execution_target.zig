/// The target Amazon S3 location for the test set execution using a bot alias.
pub const BotAliasTestExecutionTarget = struct {
    /// The bot alias Id of the bot alias used in the test set execution.
    bot_alias_id: []const u8,

    /// The bot Id of the bot alias used in the test set execution.
    bot_id: []const u8,

    /// The locale Id of the bot alias used in the test set execution.
    locale_id: []const u8,

    pub const json_field_names = .{
        .bot_alias_id = "botAliasId",
        .bot_id = "botId",
        .locale_id = "localeId",
    };
};
