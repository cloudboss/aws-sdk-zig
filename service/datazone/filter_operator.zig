pub const FilterOperator = enum {
    eq,
    le,
    lt,
    ge,
    gt,
    text_search,

    pub const json_field_names = .{
        .eq = "EQ",
        .le = "LE",
        .lt = "LT",
        .ge = "GE",
        .gt = "GT",
        .text_search = "TEXT_SEARCH",
    };
};
