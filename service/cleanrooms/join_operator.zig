pub const JoinOperator = enum {
    @"or",
    @"and",

    pub const json_field_names = .{
        .@"or" = "OR",
        .@"and" = "AND",
    };
};
