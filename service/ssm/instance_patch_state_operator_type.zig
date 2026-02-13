pub const InstancePatchStateOperatorType = enum {
    equal,
    not_equal,
    less_than,
    greater_than,

    pub const json_field_names = .{
        .equal = "EQUAL",
        .not_equal = "NOT_EQUAL",
        .less_than = "LESS_THAN",
        .greater_than = "GREATER_THAN",
    };
};
