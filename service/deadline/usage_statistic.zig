pub const UsageStatistic = enum {
    sum,
    min,
    max,
    avg,

    pub const json_field_names = .{
        .sum = "SUM",
        .min = "MIN",
        .max = "MAX",
        .avg = "AVG",
    };
};
