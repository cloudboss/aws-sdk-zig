pub const Statistic = enum {
    sum,
    max,
    avg,

    pub const json_field_names = .{
        .sum = "SUM",
        .max = "MAX",
        .avg = "AVG",
    };
};
