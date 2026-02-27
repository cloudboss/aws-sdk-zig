pub const AnalyticsSessionSortByName = enum {
    conversation_start_time,
    number_of_turns,
    duration,

    pub const json_field_names = .{
        .conversation_start_time = "ConversationStartTime",
        .number_of_turns = "NumberOfTurns",
        .duration = "Duration",
    };
};
