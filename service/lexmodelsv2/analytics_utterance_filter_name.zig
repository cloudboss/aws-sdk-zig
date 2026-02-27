pub const AnalyticsUtteranceFilterName = enum {
    bot_alias_id,
    bot_version,
    locale_id,
    modality,
    channel,
    session_id,
    originating_request_id,
    utterance_state,
    utterance_text,

    pub const json_field_names = .{
        .bot_alias_id = "BotAliasId",
        .bot_version = "BotVersion",
        .locale_id = "LocaleId",
        .modality = "Modality",
        .channel = "Channel",
        .session_id = "SessionId",
        .originating_request_id = "OriginatingRequestId",
        .utterance_state = "UtteranceState",
        .utterance_text = "UtteranceText",
    };
};
