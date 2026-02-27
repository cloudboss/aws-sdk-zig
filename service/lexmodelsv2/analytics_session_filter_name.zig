pub const AnalyticsSessionFilterName = enum {
    bot_alias_id,
    bot_version,
    locale_id,
    modality,
    channel,
    duration,
    conversation_end_state,
    session_id,
    originating_request_id,
    intent_path,

    pub const json_field_names = .{
        .bot_alias_id = "BotAliasId",
        .bot_version = "BotVersion",
        .locale_id = "LocaleId",
        .modality = "Modality",
        .channel = "Channel",
        .duration = "Duration",
        .conversation_end_state = "ConversationEndState",
        .session_id = "SessionId",
        .originating_request_id = "OriginatingRequestId",
        .intent_path = "IntentPath",
    };
};
