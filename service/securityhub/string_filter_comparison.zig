pub const StringFilterComparison = enum {
    equals,
    prefix,
    not_equals,
    prefix_not_equals,
    contains,
    not_contains,
    contains_word,

    pub const json_field_names = .{
        .equals = "EQUALS",
        .prefix = "PREFIX",
        .not_equals = "NOT_EQUALS",
        .prefix_not_equals = "PREFIX_NOT_EQUALS",
        .contains = "CONTAINS",
        .not_contains = "NOT_CONTAINS",
        .contains_word = "CONTAINS_WORD",
    };
};
