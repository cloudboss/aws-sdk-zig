pub const AnalyticsSessionField = enum {
    conversation_end_state,
    locale_id,

    pub const json_field_names = .{
        .conversation_end_state = "ConversationEndState",
        .locale_id = "LocaleId",
    };
};
