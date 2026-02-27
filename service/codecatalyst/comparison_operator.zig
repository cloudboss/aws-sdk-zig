pub const ComparisonOperator = enum {
    equals,
    greater_than,
    greater_than_or_equals,
    less_than,
    less_than_or_equals,
    begins_with,

    pub const json_field_names = .{
        .equals = "EQUALS",
        .greater_than = "GREATER_THAN",
        .greater_than_or_equals = "GREATER_THAN_OR_EQUALS",
        .less_than = "LESS_THAN",
        .less_than_or_equals = "LESS_THAN_OR_EQUALS",
        .begins_with = "BEGINS_WITH",
    };
};
