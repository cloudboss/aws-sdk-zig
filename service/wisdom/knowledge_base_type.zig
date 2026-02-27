pub const KnowledgeBaseType = enum {
    external,
    custom,
    quick_responses,

    pub const json_field_names = .{
        .external = "EXTERNAL",
        .custom = "CUSTOM",
        .quick_responses = "QUICK_RESPONSES",
    };
};
