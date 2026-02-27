pub const MetricStatistic = enum {
    average,
    minimum,
    maximum,
    sample_count,
    sum,

    pub const json_field_names = .{
        .average = "Average",
        .minimum = "Minimum",
        .maximum = "Maximum",
        .sample_count = "SampleCount",
        .sum = "Sum",
    };
};
