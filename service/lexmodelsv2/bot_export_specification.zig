/// Provides the identity of a the bot that was exported.
pub const BotExportSpecification = struct {
    /// The identifier of the bot assigned by Amazon Lex.
    bot_id: []const u8,

    /// The version of the bot that was exported. This will be either
    /// `DRAFT` or the version number.
    bot_version: []const u8,

    pub const json_field_names = .{
        .bot_id = "botId",
        .bot_version = "botVersion",
    };
};
