pub const DateTimeComparisonType = enum {
    greater_than,
    less_than,
    greater_than_or_equal_to,
    less_than_or_equal_to,
    equal_to,
    range,

    pub const json_field_names = .{
        .greater_than = "GREATER_THAN",
        .less_than = "LESS_THAN",
        .greater_than_or_equal_to = "GREATER_THAN_OR_EQUAL_TO",
        .less_than_or_equal_to = "LESS_THAN_OR_EQUAL_TO",
        .equal_to = "EQUAL_TO",
        .range = "RANGE",
    };
};
