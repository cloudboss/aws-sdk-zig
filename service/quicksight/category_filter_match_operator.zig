pub const CategoryFilterMatchOperator = enum {
    equals,
    does_not_equal,
    contains,
    does_not_contain,
    starts_with,
    ends_with,

    pub const json_field_names = .{
        .equals = "EQUALS",
        .does_not_equal = "DOES_NOT_EQUAL",
        .contains = "CONTAINS",
        .does_not_contain = "DOES_NOT_CONTAIN",
        .starts_with = "STARTS_WITH",
        .ends_with = "ENDS_WITH",
    };
};
