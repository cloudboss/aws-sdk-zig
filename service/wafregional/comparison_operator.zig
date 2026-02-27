pub const ComparisonOperator = enum {
    eq,
    ne,
    le,
    lt,
    ge,
    gt,

    pub const json_field_names = .{
        .eq = "EQ",
        .ne = "NE",
        .le = "LE",
        .lt = "LT",
        .ge = "GE",
        .gt = "GT",
    };
};
