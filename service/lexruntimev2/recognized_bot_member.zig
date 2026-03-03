/// The bot member that processes the request.
pub const RecognizedBotMember = struct {
    /// The identifier of the bot member that processes the request.
    bot_id: []const u8,

    /// The name of the bot member that processes the request.
    bot_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .bot_id = "botId",
        .bot_name = "botName",
    };
};
