pub const MatchOption = enum {
    equals,
    absent,
    starts_with,
    ends_with,
    contains,
    case_sensitive,
    case_insensitive,
    greater_than_or_equal,

    pub const json_field_names = .{
        .equals = "EQUALS",
        .absent = "ABSENT",
        .starts_with = "STARTS_WITH",
        .ends_with = "ENDS_WITH",
        .contains = "CONTAINS",
        .case_sensitive = "CASE_SENSITIVE",
        .case_insensitive = "CASE_INSENSITIVE",
        .greater_than_or_equal = "GREATER_THAN_OR_EQUAL",
    };
};
