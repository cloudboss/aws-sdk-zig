pub const AnalyticsIntentField = enum {
    intent_name,
    intent_end_state,
    intent_level,

    pub const json_field_names = .{
        .intent_name = "IntentName",
        .intent_end_state = "IntentEndState",
        .intent_level = "IntentLevel",
    };
};
