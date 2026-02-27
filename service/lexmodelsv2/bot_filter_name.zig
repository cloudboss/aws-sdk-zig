pub const BotFilterName = enum {
    bot_name,
    bot_type,

    pub const json_field_names = .{
        .bot_name = "BotName",
        .bot_type = "BotType",
    };
};
