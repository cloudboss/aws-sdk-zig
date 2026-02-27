pub const SortOrder = enum {
    desc,
    asc,

    pub const json_field_names = .{
        .desc = "DESC",
        .asc = "ASC",
    };
};
