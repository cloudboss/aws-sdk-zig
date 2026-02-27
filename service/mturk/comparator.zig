pub const Comparator = enum {
    less_than,
    less_than_or_equal_to,
    greater_than,
    greater_than_or_equal_to,
    equal_to,
    not_equal_to,
    exists,
    does_not_exist,
    in,
    not_in,

    pub const json_field_names = .{
        .less_than = "LessThan",
        .less_than_or_equal_to = "LessThanOrEqualTo",
        .greater_than = "GreaterThan",
        .greater_than_or_equal_to = "GreaterThanOrEqualTo",
        .equal_to = "EqualTo",
        .not_equal_to = "NotEqualTo",
        .exists = "Exists",
        .does_not_exist = "DoesNotExist",
        .in = "In",
        .not_in = "NotIn",
    };
};
