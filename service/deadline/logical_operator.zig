pub const LogicalOperator = enum {
    @"and",
    @"or",

    pub const json_field_names = .{
        .@"and" = "AND",
        .@"or" = "OR",
    };
};
