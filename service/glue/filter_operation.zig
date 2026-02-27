pub const FilterOperation = enum {
    eq,
    lt,
    gt,
    lte,
    gte,
    regex,
    isnull,

    pub const json_field_names = .{
        .eq = "EQ",
        .lt = "LT",
        .gt = "GT",
        .lte = "LTE",
        .gte = "GTE",
        .regex = "REGEX",
        .isnull = "ISNULL",
    };
};
