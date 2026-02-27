pub const FilterOperator = enum {
    gt,
    ge,
    lt,
    le,
    eq,
    ne,

    pub const json_field_names = .{
        .gt = "GT",
        .ge = "GE",
        .lt = "LT",
        .le = "LE",
        .eq = "EQ",
        .ne = "NE",
    };
};
