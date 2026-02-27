pub const FilterOperator = enum {
    equals,
    greater_than_or_equals,
    less_than_or_equals,

    pub const json_field_names = .{
        .equals = "EQUALS",
        .greater_than_or_equals = "GREATER_THAN_OR_EQUALS",
        .less_than_or_equals = "LESS_THAN_OR_EQUALS",
    };
};
