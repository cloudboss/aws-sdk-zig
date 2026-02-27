pub const ActionFailurePolicy = enum {
    @"continue",
    drop,

    pub const json_field_names = .{
        .@"continue" = "CONTINUE",
        .drop = "DROP",
    };
};
