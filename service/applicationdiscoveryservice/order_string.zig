pub const orderString = enum {
    asc,
    desc,

    pub const json_field_names = .{
        .asc = "ASC",
        .desc = "DESC",
    };
};
