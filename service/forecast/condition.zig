pub const Condition = enum {
    equals,
    not_equals,
    less_than,
    greater_than,

    pub const json_field_names = .{
        .equals = "EQUALS",
        .not_equals = "NOT_EQUALS",
        .less_than = "LESS_THAN",
        .greater_than = "GREATER_THAN",
    };
};
