pub const KnowledgeBaseSearchType = enum {
    hybrid,
    semantic,

    pub const json_field_names = .{
        .hybrid = "HYBRID",
        .semantic = "SEMANTIC",
    };
};
