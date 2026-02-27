pub const ComparisonOperator = enum {
    equal,
    not_equal,
    greater_than_equal_to,
    greater_than,
    less_than_equal_to,
    less_than,
    any_equals,
    all_not_equals,

    pub const json_field_names = .{
        .equal = "EQUAL",
        .not_equal = "NOT_EQUAL",
        .greater_than_equal_to = "GREATER_THAN_EQUAL_TO",
        .greater_than = "GREATER_THAN",
        .less_than_equal_to = "LESS_THAN_EQUAL_TO",
        .less_than = "LESS_THAN",
        .any_equals = "ANY_EQUALS",
        .all_not_equals = "ALL_NOT_EQUALS",
    };
};
