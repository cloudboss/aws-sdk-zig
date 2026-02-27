pub const MatchOption = enum {
    equals,
    starts_with,
    ends_with,
    contains,
    greater_than_or_equal,

    pub const json_field_names = .{
        .equals = "EQUALS",
        .starts_with = "STARTS_WITH",
        .ends_with = "ENDS_WITH",
        .contains = "CONTAINS",
        .greater_than_or_equal = "GREATER_THAN_OR_EQUAL",
    };
};
