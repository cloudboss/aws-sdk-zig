pub const SimpleNumericalAggregationFunction = enum {
    sum,
    average,
    min,
    max,
    count,
    distinct_count,
    @"var",
    varp,
    stdev,
    stdevp,
    median,

    pub const json_field_names = .{
        .sum = "SUM",
        .average = "AVERAGE",
        .min = "MIN",
        .max = "MAX",
        .count = "COUNT",
        .distinct_count = "DISTINCT_COUNT",
        .@"var" = "VAR",
        .varp = "VARP",
        .stdev = "STDEV",
        .stdevp = "STDEVP",
        .median = "MEDIAN",
    };
};
