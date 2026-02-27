pub const Statistic = enum {
    sample_count,
    average,
    sum,
    minimum,
    maximum,

    pub const json_field_names = .{
        .sample_count = "SAMPLE_COUNT",
        .average = "AVERAGE",
        .sum = "SUM",
        .minimum = "MINIMUM",
        .maximum = "MAXIMUM",
    };
};
