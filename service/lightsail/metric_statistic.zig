pub const MetricStatistic = enum {
    minimum,
    maximum,
    sum,
    average,
    sample_count,

    pub const json_field_names = .{
        .minimum = "Minimum",
        .maximum = "Maximum",
        .sum = "Sum",
        .average = "Average",
        .sample_count = "SampleCount",
    };
};
