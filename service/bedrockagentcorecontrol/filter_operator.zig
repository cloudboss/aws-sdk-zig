pub const FilterOperator = enum {
    equals,
    not_equals,
    greater_than,
    less_than,
    greater_than_or_equal,
    less_than_or_equal,
    contains,
    not_contains,

    pub const json_field_names = .{
        .equals = "EQUALS",
        .not_equals = "NOT_EQUALS",
        .greater_than = "GREATER_THAN",
        .less_than = "LESS_THAN",
        .greater_than_or_equal = "GREATER_THAN_OR_EQUAL",
        .less_than_or_equal = "LESS_THAN_OR_EQUAL",
        .contains = "CONTAINS",
        .not_contains = "NOT_CONTAINS",
    };
};
