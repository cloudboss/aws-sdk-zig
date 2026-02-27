pub const SearchJobsFilterOperator = enum {
    lt,
    lte,
    equal,
    gt,
    gte,
    between,
    contains,

    pub const json_field_names = .{
        .lt = "LT",
        .lte = "LTE",
        .equal = "EQUAL",
        .gt = "GT",
        .gte = "GTE",
        .between = "BETWEEN",
        .contains = "CONTAINS",
    };
};
