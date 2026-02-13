pub const ComplianceQueryOperatorType = enum {
    equal,
    not_equal,
    begin_with,
    less_than,
    greater_than,

    pub const json_field_names = .{
        .equal = "Equal",
        .not_equal = "NotEqual",
        .begin_with = "BeginWith",
        .less_than = "LessThan",
        .greater_than = "GreaterThan",
    };
};
