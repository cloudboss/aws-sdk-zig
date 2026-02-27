pub const Role = enum {
    assistant,
    user,
    tool,
    other,

    pub const json_field_names = .{
        .assistant = "ASSISTANT",
        .user = "USER",
        .tool = "TOOL",
        .other = "OTHER",
    };
};
