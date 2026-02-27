/// The operator to use in a condition. Depending on the type of condition,
/// possible values are:
pub const JobComparator = enum {
    eq,
    gt,
    gte,
    lt,
    lte,
    ne,
    contains,
    starts_with,

    pub const json_field_names = .{
        .eq = "EQ",
        .gt = "GT",
        .gte = "GTE",
        .lt = "LT",
        .lte = "LTE",
        .ne = "NE",
        .contains = "CONTAINS",
        .starts_with = "STARTS_WITH",
    };
};
