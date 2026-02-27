pub const RetrieveAndGenerateType = enum {
    knowledge_base,
    external_sources,

    pub const json_field_names = .{
        .knowledge_base = "KNOWLEDGE_BASE",
        .external_sources = "EXTERNAL_SOURCES",
    };
};
