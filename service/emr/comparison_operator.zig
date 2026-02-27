pub const ComparisonOperator = enum {
    greater_than_or_equal,
    greater_than,
    less_than,
    less_than_or_equal,

    pub const json_field_names = .{
        .greater_than_or_equal = "GREATER_THAN_OR_EQUAL",
        .greater_than = "GREATER_THAN",
        .less_than = "LESS_THAN",
        .less_than_or_equal = "LESS_THAN_OR_EQUAL",
    };
};
