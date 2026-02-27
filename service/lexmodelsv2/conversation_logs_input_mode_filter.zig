pub const ConversationLogsInputModeFilter = enum {
    speech,
    text,

    pub const json_field_names = .{
        .speech = "Speech",
        .text = "Text",
    };
};
