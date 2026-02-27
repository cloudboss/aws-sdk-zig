pub const CommandParameterValueComparisonOperator = enum {
    equals,
    not_equals,
    less_than,
    less_than_equals,
    greater_than,
    greater_than_equals,
    in_set,
    not_in_set,
    in_range,
    not_in_range,

    pub const json_field_names = .{
        .equals = "EQUALS",
        .not_equals = "NOT_EQUALS",
        .less_than = "LESS_THAN",
        .less_than_equals = "LESS_THAN_EQUALS",
        .greater_than = "GREATER_THAN",
        .greater_than_equals = "GREATER_THAN_EQUALS",
        .in_set = "IN_SET",
        .not_in_set = "NOT_IN_SET",
        .in_range = "IN_RANGE",
        .not_in_range = "NOT_IN_RANGE",
    };
};
