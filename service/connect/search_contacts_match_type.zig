pub const SearchContactsMatchType = enum {
    match_all,
    match_any,
    match_exact,
    match_none,

    pub const json_field_names = .{
        .match_all = "MATCH_ALL",
        .match_any = "MATCH_ANY",
        .match_exact = "MATCH_EXACT",
        .match_none = "MATCH_NONE",
    };
};
