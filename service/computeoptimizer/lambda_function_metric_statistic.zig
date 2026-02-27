pub const LambdaFunctionMetricStatistic = enum {
    maximum,
    average,

    pub const json_field_names = .{
        .maximum = "MAXIMUM",
        .average = "AVERAGE",
    };
};
