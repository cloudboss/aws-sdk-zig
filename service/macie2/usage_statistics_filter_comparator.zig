/// The operator to use in a condition that filters the results of a query for
/// Amazon Macie account quotas and usage data. Valid values are:
pub const UsageStatisticsFilterComparator = enum {
    gt,
    gte,
    lt,
    lte,
    eq,
    ne,
    contains,

    pub const json_field_names = .{
        .gt = "GT",
        .gte = "GTE",
        .lt = "LT",
        .lte = "LTE",
        .eq = "EQ",
        .ne = "NE",
        .contains = "CONTAINS",
    };
};
