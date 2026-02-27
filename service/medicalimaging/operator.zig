pub const Operator = enum {
    equal,
    between,

    pub const json_field_names = .{
        .equal = "EQUAL",
        .between = "BETWEEN",
    };
};
