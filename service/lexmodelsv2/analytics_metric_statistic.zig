pub const AnalyticsMetricStatistic = enum {
    sum,
    avg,
    max,

    pub const json_field_names = .{
        .sum = "Sum",
        .avg = "Avg",
        .max = "Max",
    };
};
