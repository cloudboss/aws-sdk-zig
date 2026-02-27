pub const DateAggregationFunction = enum {
    count,
    distinct_count,
    min,
    max,

    pub const json_field_names = .{
        .count = "COUNT",
        .distinct_count = "DISTINCT_COUNT",
        .min = "MIN",
        .max = "MAX",
    };
};
