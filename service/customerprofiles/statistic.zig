pub const Statistic = enum {
    first_occurrence,
    last_occurrence,
    count,
    sum,
    minimum,
    maximum,
    average,
    max_occurrence,

    pub const json_field_names = .{
        .first_occurrence = "FIRST_OCCURRENCE",
        .last_occurrence = "LAST_OCCURRENCE",
        .count = "COUNT",
        .sum = "SUM",
        .minimum = "MINIMUM",
        .maximum = "MAXIMUM",
        .average = "AVERAGE",
        .max_occurrence = "MAX_OCCURRENCE",
    };
};
