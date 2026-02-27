pub const DataPrepSimpleAggregationFunctionType = enum {
    count,
    distinct_count,
    sum,
    average,
    max,
    min,

    pub const json_field_names = .{
        .count = "COUNT",
        .distinct_count = "DISTINCT_COUNT",
        .sum = "SUM",
        .average = "AVERAGE",
        .max = "MAX",
        .min = "MIN",
    };
};
