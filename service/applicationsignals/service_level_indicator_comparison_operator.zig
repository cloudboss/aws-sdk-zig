pub const ServiceLevelIndicatorComparisonOperator = enum {
    greater_than_or_equal_to,
    greater_than,
    less_than,
    less_than_or_equal_to,

    pub const json_field_names = .{
        .greater_than_or_equal_to = "GREATER_THAN_OR_EQUAL_TO",
        .greater_than = "GREATER_THAN",
        .less_than = "LESS_THAN",
        .less_than_or_equal_to = "LESS_THAN_OR_EQUAL_TO",
    };
};
