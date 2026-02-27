pub const ComparisonOperator = enum {
    greater,
    greater_or_equal,
    less,
    less_or_equal,
    equal,
    not_equal,

    pub const json_field_names = .{
        .greater = "GREATER",
        .greater_or_equal = "GREATER_OR_EQUAL",
        .less = "LESS",
        .less_or_equal = "LESS_OR_EQUAL",
        .equal = "EQUAL",
        .not_equal = "NOT_EQUAL",
    };
};
