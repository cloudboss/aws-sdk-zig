pub const Operator = enum {
    equals,
    not_equals,
    greater_than,
    greater_than_or_equal_to,
    less_than,
    less_than_or_equal_to,
    contains,
    exists,
    not_exists,
    in,

    pub const json_field_names = .{
        .equals = "EQUALS",
        .not_equals = "NOT_EQUALS",
        .greater_than = "GREATER_THAN",
        .greater_than_or_equal_to = "GREATER_THAN_OR_EQUAL_TO",
        .less_than = "LESS_THAN",
        .less_than_or_equal_to = "LESS_THAN_OR_EQUAL_TO",
        .contains = "CONTAINS",
        .exists = "EXISTS",
        .not_exists = "NOT_EXISTS",
        .in = "IN",
    };
};
