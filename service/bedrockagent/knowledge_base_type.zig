pub const KnowledgeBaseType = enum {
    vector,
    kendra,
    sql,

    pub const json_field_names = .{
        .vector = "VECTOR",
        .kendra = "KENDRA",
        .sql = "SQL",
    };
};
