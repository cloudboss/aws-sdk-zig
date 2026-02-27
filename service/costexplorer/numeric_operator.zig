pub const NumericOperator = enum {
    equal,
    greater_than_or_equal,
    less_than_or_equal,
    greater_than,
    less_than,
    between,

    pub const json_field_names = .{
        .equal = "EQUAL",
        .greater_than_or_equal = "GREATER_THAN_OR_EQUAL",
        .less_than_or_equal = "LESS_THAN_OR_EQUAL",
        .greater_than = "GREATER_THAN",
        .less_than = "LESS_THAN",
        .between = "BETWEEN",
    };
};
