pub const AssociationType = enum {
    knowledge_base,
    external_bedrock_knowledge_base,

    pub const json_field_names = .{
        .knowledge_base = "KNOWLEDGE_BASE",
        .external_bedrock_knowledge_base = "EXTERNAL_BEDROCK_KNOWLEDGE_BASE",
    };
};
