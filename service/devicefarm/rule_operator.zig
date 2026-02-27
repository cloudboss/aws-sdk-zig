pub const RuleOperator = enum {
    equals,
    less_than,
    less_than_or_equals,
    greater_than,
    greater_than_or_equals,
    in,
    not_in,
    contains,

    pub const json_field_names = .{
        .equals = "EQUALS",
        .less_than = "LESS_THAN",
        .less_than_or_equals = "LESS_THAN_OR_EQUALS",
        .greater_than = "GREATER_THAN",
        .greater_than_or_equals = "GREATER_THAN_OR_EQUALS",
        .in = "IN",
        .not_in = "NOT_IN",
        .contains = "CONTAINS",
    };
};
