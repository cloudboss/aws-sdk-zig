pub const Source = enum {
    action_group,
    knowledge_base,
    parser,

    pub const json_field_names = .{
        .action_group = "ACTION_GROUP",
        .knowledge_base = "KNOWLEDGE_BASE",
        .parser = "PARSER",
    };
};
