pub const NodeFilterOperatorType = enum {
    equal,
    not_equal,
    begin_with,

    pub const json_field_names = .{
        .equal = "EQUAL",
        .not_equal = "NOT_EQUAL",
        .begin_with = "BEGIN_WITH",
    };
};
