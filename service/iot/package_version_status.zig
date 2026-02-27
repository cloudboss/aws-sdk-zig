pub const PackageVersionStatus = enum {
    draft,
    published,
    deprecated,

    pub const json_field_names = .{
        .draft = "DRAFT",
        .published = "PUBLISHED",
        .deprecated = "DEPRECATED",
    };
};
