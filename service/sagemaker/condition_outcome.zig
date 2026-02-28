pub const ConditionOutcome = enum {
    @"true",
    @"false",

    pub const json_field_names = .{
        .@"true" = "TRUE",
        .@"false" = "FALSE",
    };
};
