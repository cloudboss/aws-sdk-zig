pub const PromptTemplateType = enum {
    text,
    chat,

    pub const json_field_names = .{
        .text = "TEXT",
        .chat = "CHAT",
    };
};
