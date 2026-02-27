pub const SimpleTotalAggregationFunction = enum {
    default,
    sum,
    average,
    min,
    max,
    none,

    pub const json_field_names = .{
        .default = "DEFAULT",
        .sum = "SUM",
        .average = "AVERAGE",
        .min = "MIN",
        .max = "MAX",
        .none = "NONE",
    };
};
