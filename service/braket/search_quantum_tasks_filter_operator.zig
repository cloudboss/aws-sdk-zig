pub const SearchQuantumTasksFilterOperator = enum {
    lt,
    lte,
    equal,
    gt,
    gte,
    between,

    pub const json_field_names = .{
        .lt = "LT",
        .lte = "LTE",
        .equal = "EQUAL",
        .gt = "GT",
        .gte = "GTE",
        .between = "BETWEEN",
    };
};
