pub const Operator = enum {
    equals,
    not_equals,
    greater_than,
    less_than,
    greater_than_or_equal_to,
    less_than_or_equal_to,
    contains,
    does_not_contain,
    between,

    pub const json_field_names = .{
        .equals = "EQUALS",
        .not_equals = "NOT_EQUALS",
        .greater_than = "GREATER_THAN",
        .less_than = "LESS_THAN",
        .greater_than_or_equal_to = "GREATER_THAN_OR_EQUAL_TO",
        .less_than_or_equal_to = "LESS_THAN_OR_EQUAL_TO",
        .contains = "CONTAINS",
        .does_not_contain = "DOES_NOT_CONTAIN",
        .between = "BETWEEN",
    };
};
