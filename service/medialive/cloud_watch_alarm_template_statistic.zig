/// The statistic to apply to the alarm's metric data.
pub const CloudWatchAlarmTemplateStatistic = enum {
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
