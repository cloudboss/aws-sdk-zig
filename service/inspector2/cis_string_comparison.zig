pub const CisStringComparison = enum {
    equals,
    prefix,
    not_equals,

    pub const json_field_names = .{
        .equals = "EQUALS",
        .prefix = "PREFIX",
        .not_equals = "NOT_EQUALS",
    };
};
