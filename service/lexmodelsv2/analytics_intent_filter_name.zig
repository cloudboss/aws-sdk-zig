pub const AnalyticsIntentFilterName = enum {
    bot_alias_id,
    bot_version,
    locale_id,
    modality,
    channel,
    session_id,
    originating_request_id,
    intent_name,
    intent_end_state,

    pub const json_field_names = .{
        .bot_alias_id = "BotAliasId",
        .bot_version = "BotVersion",
        .locale_id = "LocaleId",
        .modality = "Modality",
        .channel = "Channel",
        .session_id = "SessionId",
        .originating_request_id = "OriginatingRequestId",
        .intent_name = "IntentName",
        .intent_end_state = "IntentEndState",
    };
};
