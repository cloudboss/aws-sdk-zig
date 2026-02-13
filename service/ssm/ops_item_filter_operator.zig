pub const OpsItemFilterOperator = enum {
    equal,
    contains,
    greater_than,
    less_than,

    pub const json_field_names = .{
        .equal = "EQUAL",
        .contains = "CONTAINS",
        .greater_than = "GREATER_THAN",
        .less_than = "LESS_THAN",
    };
};
