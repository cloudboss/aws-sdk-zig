pub const AuthorSpecifiedAggregation = enum {
    count,
    distinct_count,
    min,
    max,
    median,
    sum,
    average,
    stdev,
    stdevp,
    @"var",
    varp,
    percentile,

    pub const json_field_names = .{
        .count = "COUNT",
        .distinct_count = "DISTINCT_COUNT",
        .min = "MIN",
        .max = "MAX",
        .median = "MEDIAN",
        .sum = "SUM",
        .average = "AVERAGE",
        .stdev = "STDEV",
        .stdevp = "STDEVP",
        .@"var" = "VAR",
        .varp = "VARP",
        .percentile = "PERCENTILE",
    };
};
