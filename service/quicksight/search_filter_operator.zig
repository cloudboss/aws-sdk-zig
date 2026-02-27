pub const SearchFilterOperator = enum {
    string_equals,
    string_like,

    pub const json_field_names = .{
        .string_equals = "STRING_EQUALS",
        .string_like = "STRING_LIKE",
    };
};
