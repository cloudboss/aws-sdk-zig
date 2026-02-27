pub const StreamExceptionPolicy = enum {
    drop,
    @"continue",
    reject,

    pub const json_field_names = .{
        .drop = "DROP",
        .@"continue" = "CONTINUE",
        .reject = "REJECT",
    };
};
