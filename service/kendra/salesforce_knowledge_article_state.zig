pub const SalesforceKnowledgeArticleState = enum {
    draft,
    published,
    archived,

    pub const json_field_names = .{
        .draft = "DRAFT",
        .published = "PUBLISHED",
        .archived = "ARCHIVED",
    };
};
