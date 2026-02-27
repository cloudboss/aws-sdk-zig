pub const BotType = enum {
    bot,
    bot_network,

    pub const json_field_names = .{
        .bot = "Bot",
        .bot_network = "BotNetwork",
    };
};
