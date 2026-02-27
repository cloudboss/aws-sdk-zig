pub const LensStatusType = enum {
    all,
    draft,
    published,

    pub const json_field_names = .{
        .all = "ALL",
        .draft = "DRAFT",
        .published = "PUBLISHED",
    };
};
