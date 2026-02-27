pub const ComparisonOperator = enum {
    /// EQUALS
    equals,
    /// NOT_EQUALS
    not_equals,
    /// STARTS_WITH
    starts_with,

    pub const json_field_names = .{
        .equals = "EQUALS",
        .not_equals = "NOT_EQUALS",
        .starts_with = "STARTS_WITH",
    };
};
