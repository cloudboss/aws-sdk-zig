pub const Order = enum {
    asc,
    desc,

    pub const json_field_names = .{
        .asc = "ASC",
        .desc = "DESC",
    };
};
