pub const Operator = enum {
    eq,
    ne,
    in,
    le,
    lt,
    ge,
    gt,
    contains,
    not_contains,
    begins_with,

    pub const json_field_names = .{
        .eq = "EQ",
        .ne = "NE",
        .in = "IN",
        .le = "LE",
        .lt = "LT",
        .ge = "GE",
        .gt = "GT",
        .contains = "CONTAINS",
        .not_contains = "NOT_CONTAINS",
        .begins_with = "BEGINS_WITH",
    };
};
