pub const RepositorySortBy = enum {
    critical,
    high,
    all,
    affected_images,

    pub const json_field_names = .{
        .critical = "CRITICAL",
        .high = "HIGH",
        .all = "ALL",
        .affected_images = "AFFECTED_IMAGES",
    };
};
