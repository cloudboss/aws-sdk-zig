pub const SearchFieldOperator = enum {
    equals,
    includes,

    pub const json_field_names = .{
        .equals = "EQUALS",
        .includes = "INCLUDES",
    };
};
