pub const ClaimMatchOperatorType = enum {
    equals,
    contains,
    contains_any,

    pub const json_field_names = .{
        .equals = "EQUALS",
        .contains = "CONTAINS",
        .contains_any = "CONTAINS_ANY",
    };
};
