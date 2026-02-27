pub const DifferentialPrivacyAggregationType = enum {
    avg,
    count,
    count_distinct,
    sum,
    stddev,

    pub const json_field_names = .{
        .avg = "AVG",
        .count = "COUNT",
        .count_distinct = "COUNT_DISTINCT",
        .sum = "SUM",
        .stddev = "STDDEV",
    };
};
