pub const ProductViewSortBy = enum {
    title,
    version_count,
    creation_date,

    pub const json_field_names = .{
        .title = "Title",
        .version_count = "VersionCount",
        .creation_date = "CreationDate",
    };
};
