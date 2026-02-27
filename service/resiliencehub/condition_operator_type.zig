pub const ConditionOperatorType = enum {
    equals,
    not_equals,
    greater_then,
    greater_or_equals,
    less_then,
    less_or_equals,

    pub const json_field_names = .{
        .equals = "EQUALS",
        .not_equals = "NOT_EQUALS",
        .greater_then = "GREATER_THEN",
        .greater_or_equals = "GREATER_OR_EQUALS",
        .less_then = "LESS_THEN",
        .less_or_equals = "LESS_OR_EQUALS",
    };
};
