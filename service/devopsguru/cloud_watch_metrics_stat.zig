pub const CloudWatchMetricsStat = enum {
    sum,
    average,
    sample_count,
    minimum,
    maximum,
    p99,
    p90,
    p50,

    pub const json_field_names = .{
        .sum = "SUM",
        .average = "AVERAGE",
        .sample_count = "SAMPLE_COUNT",
        .minimum = "MINIMUM",
        .maximum = "MAXIMUM",
        .p99 = "P99",
        .p90 = "P90",
        .p50 = "P50",
    };
};
