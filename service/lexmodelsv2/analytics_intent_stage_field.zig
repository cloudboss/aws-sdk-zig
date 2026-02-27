pub const AnalyticsIntentStageField = enum {
    intent_stage_name,
    switched_to_intent,

    pub const json_field_names = .{
        .intent_stage_name = "IntentStageName",
        .switched_to_intent = "SwitchedToIntent",
    };
};
