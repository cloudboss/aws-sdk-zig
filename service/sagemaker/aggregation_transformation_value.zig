pub const AggregationTransformationValue = enum {
    sum,
    avg,
    first,
    min,
    max,

    pub const json_field_names = .{
        .sum = "Sum",
        .avg = "Avg",
        .first = "First",
        .min = "Min",
        .max = "Max",
    };
};
