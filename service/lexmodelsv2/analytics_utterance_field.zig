pub const AnalyticsUtteranceField = enum {
    utterance_text,
    utterance_state,

    pub const json_field_names = .{
        .utterance_text = "UtteranceText",
        .utterance_state = "UtteranceState",
    };
};
