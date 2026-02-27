pub const Operator = enum {
    equal_to,
    greater_than,
    less_than,
    not_equal_to,

    pub const json_field_names = .{
        .equal_to = "EQUAL_TO",
        .greater_than = "GREATER_THAN",
        .less_than = "LESS_THAN",
        .not_equal_to = "NOT_EQUAL_TO",
    };
};
