pub const MappingRuleMatchType = enum {
    equals,
    contains,
    starts_with,
    not_equal,

    pub const json_field_names = .{
        .equals = "EQUALS",
        .contains = "CONTAINS",
        .starts_with = "STARTS_WITH",
        .not_equal = "NOT_EQUAL",
    };
};
