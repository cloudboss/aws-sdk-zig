pub const TitleSortBy = enum {
    critical,
    high,
    all,

    pub const json_field_names = .{
        .critical = "CRITICAL",
        .high = "HIGH",
        .all = "ALL",
    };
};
