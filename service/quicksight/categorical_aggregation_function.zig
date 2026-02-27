pub const CategoricalAggregationFunction = enum {
    count,
    distinct_count,

    pub const json_field_names = .{
        .count = "COUNT",
        .distinct_count = "DISTINCT_COUNT",
    };
};
