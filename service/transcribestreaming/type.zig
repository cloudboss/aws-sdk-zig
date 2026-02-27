pub const Type = enum {
    conversation,
    dictation,

    pub const json_field_names = .{
        .conversation = "CONVERSATION",
        .dictation = "DICTATION",
    };
};
