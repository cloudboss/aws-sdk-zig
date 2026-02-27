pub const MetricAggregationType = enum {
    average,
    minimum,
    maximum,

    pub const json_field_names = .{
        .average = "Average",
        .minimum = "Minimum",
        .maximum = "Maximum",
    };
};
