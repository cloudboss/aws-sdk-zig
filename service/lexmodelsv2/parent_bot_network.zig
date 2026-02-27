/// A network of bots.
pub const ParentBotNetwork = struct {
    /// The identifier of the network of bots assigned by Amazon Lex.
    bot_id: []const u8,

    /// The version of the network of bots.
    bot_version: []const u8,

    pub const json_field_names = .{
        .bot_id = "botId",
        .bot_version = "botVersion",
    };
};
