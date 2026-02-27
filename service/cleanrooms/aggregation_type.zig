pub const AggregationType = enum {
    count_distinct,

    pub const json_field_names = .{
        .count_distinct = "COUNT_DISTINCT",
    };
};
