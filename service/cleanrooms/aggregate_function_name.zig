pub const AggregateFunctionName = enum {
    sum,
    sum_distinct,
    count,
    count_distinct,
    avg,

    pub const json_field_names = .{
        .sum = "SUM",
        .sum_distinct = "SUM_DISTINCT",
        .count = "COUNT",
        .count_distinct = "COUNT_DISTINCT",
        .avg = "AVG",
    };
};
