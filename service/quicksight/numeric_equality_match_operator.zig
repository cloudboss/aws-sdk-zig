pub const NumericEqualityMatchOperator = enum {
    equals,
    does_not_equal,

    pub const json_field_names = .{
        .equals = "EQUALS",
        .does_not_equal = "DOES_NOT_EQUAL",
    };
};
