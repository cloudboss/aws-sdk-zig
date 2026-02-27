pub const AggregateType = enum {
    average,
    count,
    maximum,
    minimum,
    sum,
    standard_deviation,

    pub const json_field_names = .{
        .average = "AVERAGE",
        .count = "COUNT",
        .maximum = "MAXIMUM",
        .minimum = "MINIMUM",
        .sum = "SUM",
        .standard_deviation = "STANDARD_DEVIATION",
    };
};
