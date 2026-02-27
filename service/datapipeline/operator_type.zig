pub const OperatorType = enum {
    equal,
    reference_equal,
    less_than_or_equal,
    greater_than_or_equal,
    between,

    pub const json_field_names = .{
        .equal = "Equal",
        .reference_equal = "ReferenceEqual",
        .less_than_or_equal = "LessThanOrEqual",
        .greater_than_or_equal = "GreaterThanOrEqual",
        .between = "Between",
    };
};
