pub const FilterCondition = enum {
    eq,
    in,
    between,
    begins_with,

    pub const json_field_names = .{
        .eq = "EQ",
        .in = "IN",
        .between = "BETWEEN",
        .begins_with = "BEGINS_WITH",
    };
};
