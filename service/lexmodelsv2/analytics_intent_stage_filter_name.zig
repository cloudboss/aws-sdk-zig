pub const AnalyticsIntentStageFilterName = enum {
    bot_alias_id,
    bot_version,
    locale_id,
    modality,
    channel,
    session_id,
    originating_request_id,
    intent_name,
    intent_stage_name,

    pub const json_field_names = .{
        .bot_alias_id = "BotAliasId",
        .bot_version = "BotVersion",
        .locale_id = "LocaleId",
        .modality = "Modality",
        .channel = "Channel",
        .session_id = "SessionId",
        .originating_request_id = "OriginatingRequestId",
        .intent_name = "IntentName",
        .intent_stage_name = "IntentStageName",
    };
};
