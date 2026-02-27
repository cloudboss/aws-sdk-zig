pub const Operator = enum {
    le,
    ge,
    begins_with,

    pub const json_field_names = .{
        .le = "LE",
        .ge = "GE",
        .begins_with = "BEGINS_WITH",
    };
};
