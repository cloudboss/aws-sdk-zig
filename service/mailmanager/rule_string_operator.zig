pub const RuleStringOperator = enum {
    equals,
    not_equals,
    starts_with,
    ends_with,
    contains,

    pub const json_field_names = .{
        .equals = "EQUALS",
        .not_equals = "NOT_EQUALS",
        .starts_with = "STARTS_WITH",
        .ends_with = "ENDS_WITH",
        .contains = "CONTAINS",
    };
};
