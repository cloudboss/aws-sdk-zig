pub const Comparator = enum {
    equals,
    greater_than,
    less_than,
    greater_than_equals,
    less_than_equals,

    pub const json_field_names = .{
        .equals = "EQUALS",
        .greater_than = "GREATER_THAN",
        .less_than = "LESS_THAN",
        .greater_than_equals = "GREATER_THAN_EQUALS",
        .less_than_equals = "LESS_THAN_EQUALS",
    };
};
