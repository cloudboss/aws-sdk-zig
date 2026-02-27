pub const GuardrailTopicAction = enum {
    block,
    none,

    pub const json_field_names = .{
        .block = "BLOCK",
        .none = "NONE",
    };
};
