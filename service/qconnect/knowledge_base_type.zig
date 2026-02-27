pub const KnowledgeBaseType = enum {
    external,
    custom,
    quick_responses,
    message_templates,
    managed,

    pub const json_field_names = .{
        .external = "EXTERNAL",
        .custom = "CUSTOM",
        .quick_responses = "QUICK_RESPONSES",
        .message_templates = "MESSAGE_TEMPLATES",
        .managed = "MANAGED",
    };
};
