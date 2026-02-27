pub const MatchOption = enum {
    not_equal,
    equal,

    pub const json_field_names = .{
        .not_equal = "NOT_EQUAL",
        .equal = "EQUAL",
    };
};
