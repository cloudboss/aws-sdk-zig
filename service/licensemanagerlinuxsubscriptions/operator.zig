pub const Operator = enum {
    /// Equal operator
    equal,
    /// Not equal operator
    not_equal,
    /// Contains operator
    contains,

    pub const json_field_names = .{
        .equal = "EQUAL",
        .not_equal = "NOT_EQUAL",
        .contains = "CONTAINS",
    };
};
