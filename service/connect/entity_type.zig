pub const EntityType = enum {
    user,
    ai_agent,

    pub const json_field_names = .{
        .user = "USER",
        .ai_agent = "AI_AGENT",
    };
};
