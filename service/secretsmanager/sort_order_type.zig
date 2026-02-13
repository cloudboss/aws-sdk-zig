pub const SortOrderType = enum {
    asc,
    desc,

    pub const json_field_names = .{
        .asc = "asc",
        .desc = "desc",
    };
};
