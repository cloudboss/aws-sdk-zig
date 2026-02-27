pub const LambdaFunctionMemoryMetricStatistic = enum {
    lower_bound,
    upper_bound,
    expected,

    pub const json_field_names = .{
        .lower_bound = "LOWER_BOUND",
        .upper_bound = "UPPER_BOUND",
        .expected = "EXPECTED",
    };
};
