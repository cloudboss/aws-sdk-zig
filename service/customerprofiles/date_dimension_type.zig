pub const DateDimensionType = enum {
    before,
    after,
    between,
    not_between,
    on,

    pub const json_field_names = .{
        .before = "BEFORE",
        .after = "AFTER",
        .between = "BETWEEN",
        .not_between = "NOT_BETWEEN",
        .on = "ON",
    };
};
