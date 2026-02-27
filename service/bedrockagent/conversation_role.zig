pub const ConversationRole = enum {
    user,
    assistant,

    pub const json_field_names = .{
        .user = "USER",
        .assistant = "ASSISTANT",
    };
};
