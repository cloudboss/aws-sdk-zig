pub const FilterType = enum {
    term_match,
    equals,
    contains,
    any_of,
    none_of,

    pub const json_field_names = .{
        .term_match = "TERM_MATCH",
        .equals = "EQUALS",
        .contains = "CONTAINS",
        .any_of = "ANY_OF",
        .none_of = "NONE_OF",
    };
};
