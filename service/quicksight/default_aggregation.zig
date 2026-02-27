pub const DefaultAggregation = enum {
    sum,
    max,
    min,
    count,
    distinct_count,
    average,
    median,
    stdev,
    stdevp,
    @"var",
    varp,

    pub const json_field_names = .{
        .sum = "SUM",
        .max = "MAX",
        .min = "MIN",
        .count = "COUNT",
        .distinct_count = "DISTINCT_COUNT",
        .average = "AVERAGE",
        .median = "MEDIAN",
        .stdev = "STDEV",
        .stdevp = "STDEVP",
        .@"var" = "VAR",
        .varp = "VARP",
    };
};
