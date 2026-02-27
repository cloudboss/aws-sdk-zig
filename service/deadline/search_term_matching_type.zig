pub const SearchTermMatchingType = enum {
    fuzzy_match,
    contains,

    pub const json_field_names = .{
        .fuzzy_match = "FUZZY_MATCH",
        .contains = "CONTAINS",
    };
};
