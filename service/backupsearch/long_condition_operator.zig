pub const LongConditionOperator = enum {
    equals_to,
    not_equals_to,
    less_than_equal_to,
    greater_than_equal_to,

    pub const json_field_names = .{
        .equals_to = "EQUALS_TO",
        .not_equals_to = "NOT_EQUALS_TO",
        .less_than_equal_to = "LESS_THAN_EQUAL_TO",
        .greater_than_equal_to = "GREATER_THAN_EQUAL_TO",
    };
};
