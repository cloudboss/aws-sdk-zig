pub const AnalyticsFilterOperator = enum {
    equals,
    greater_than,
    less_than,

    pub const json_field_names = .{
        .equals = "Equals",
        .greater_than = "GreaterThan",
        .less_than = "LessThan",
    };
};
