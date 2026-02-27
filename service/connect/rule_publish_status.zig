pub const RulePublishStatus = enum {
    draft,
    published,

    pub const json_field_names = .{
        .draft = "DRAFT",
        .published = "PUBLISHED",
    };
};
