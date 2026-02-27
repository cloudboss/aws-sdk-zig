pub const NamedFilterAggType = enum {
    no_aggregation,
    sum,
    average,
    count,
    distinct_count,
    max,
    median,
    min,
    stdev,
    stdevp,
    @"var",
    varp,

    pub const json_field_names = .{
        .no_aggregation = "NO_AGGREGATION",
        .sum = "SUM",
        .average = "AVERAGE",
        .count = "COUNT",
        .distinct_count = "DISTINCT_COUNT",
        .max = "MAX",
        .median = "MEDIAN",
        .min = "MIN",
        .stdev = "STDEV",
        .stdevp = "STDEVP",
        .@"var" = "VAR",
        .varp = "VARP",
    };
};
