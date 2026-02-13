pub const AssociationFilterOperatorType = enum {
    equal,
    less_than,
    greater_than,

    pub const json_field_names = .{
        .equal = "Equal",
        .less_than = "LessThan",
        .greater_than = "GreaterThan",
    };
};
