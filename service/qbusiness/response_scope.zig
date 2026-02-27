pub const ResponseScope = enum {
    enterprise_content_only,
    extended_knowledge_enabled,

    pub const json_field_names = .{
        .enterprise_content_only = "ENTERPRISE_CONTENT_ONLY",
        .extended_knowledge_enabled = "EXTENDED_KNOWLEDGE_ENABLED",
    };
};
