pub const Channel = enum {
    voice,
    chat,
    task,
    email,

    pub const json_field_names = .{
        .voice = "VOICE",
        .chat = "CHAT",
        .task = "TASK",
        .email = "EMAIL",
    };
};
