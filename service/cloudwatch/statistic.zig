pub const Statistic = enum {
    sample_count,
    average,
    sum,
    minimum,
    maximum,

    pub const json_field_names = .{
        .sample_count = "SampleCount",
        .average = "Average",
        .sum = "Sum",
        .minimum = "Minimum",
        .maximum = "Maximum",
    };
};
