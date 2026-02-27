pub const RuleBooleanOperator = enum {
    is_true,
    is_false,

    pub const json_field_names = .{
        .is_true = "IS_TRUE",
        .is_false = "IS_FALSE",
    };
};
