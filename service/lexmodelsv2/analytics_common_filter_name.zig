pub const AnalyticsCommonFilterName = enum {
    bot_alias_id,
    bot_version,
    locale_id,
    modality,
    channel,

    pub const json_field_names = .{
        .bot_alias_id = "BotAliasId",
        .bot_version = "BotVersion",
        .locale_id = "LocaleId",
        .modality = "Modality",
        .channel = "Channel",
    };
};
