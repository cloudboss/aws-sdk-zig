pub const MetricStatistic = enum {
    min,
    max,
    avg,
    count,
    std_dev,
    last,

    pub const json_field_names = .{
        .min = "MIN",
        .max = "MAX",
        .avg = "AVG",
        .count = "COUNT",
        .std_dev = "STD_DEV",
        .last = "LAST",
    };
};
