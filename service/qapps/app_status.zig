pub const AppStatus = enum {
    published,
    draft,
    deleted,

    pub const json_field_names = .{
        .published = "PUBLISHED",
        .draft = "DRAFT",
        .deleted = "DELETED",
    };
};
