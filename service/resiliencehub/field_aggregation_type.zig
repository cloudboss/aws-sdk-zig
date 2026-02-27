pub const FieldAggregationType = enum {
    min,
    max,
    sum,
    avg,
    count,

    pub const json_field_names = .{
        .min = "MIN",
        .max = "MAX",
        .sum = "SUM",
        .avg = "AVG",
        .count = "COUNT",
    };
};
