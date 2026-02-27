pub const AnalyticsBinByName = enum {
    conversation_start_time,
    utterance_timestamp,

    pub const json_field_names = .{
        .conversation_start_time = "ConversationStartTime",
        .utterance_timestamp = "UtteranceTimestamp",
    };
};
