pub const ConditionalOperator = enum {
    @"and",
    @"or",

    pub const json_field_names = .{
        .@"and" = "AND",
        .@"or" = "OR",
    };
};
