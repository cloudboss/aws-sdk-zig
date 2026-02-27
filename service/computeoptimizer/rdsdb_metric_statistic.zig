pub const RDSDBMetricStatistic = enum {
    maximum,
    minimum,
    average,

    pub const json_field_names = .{
        .maximum = "MAXIMUM",
        .minimum = "MINIMUM",
        .average = "AVERAGE",
    };
};
