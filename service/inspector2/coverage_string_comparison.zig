pub const CoverageStringComparison = enum {
    equals,
    not_equals,

    pub const json_field_names = .{
        .equals = "EQUALS",
        .not_equals = "NOT_EQUALS",
    };
};
