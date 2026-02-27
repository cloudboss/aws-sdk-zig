pub const FilterConditionString = enum {
    is,
    is_not,

    pub const json_field_names = .{
        .is = "IS",
        .is_not = "IS_NOT",
    };
};
