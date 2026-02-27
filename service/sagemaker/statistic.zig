pub const Statistic = enum {
    average,
    minimum,
    maximum,
    sample_count,
    sum,

    pub const json_field_names = .{
        .average = "AVERAGE",
        .minimum = "MINIMUM",
        .maximum = "MAXIMUM",
        .sample_count = "SAMPLE_COUNT",
        .sum = "SUM",
    };
};
