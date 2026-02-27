pub const StreamExceptionPolicy = enum {
    drop,
    @"continue",
    reject,
    fms_ignore,

    pub const json_field_names = .{
        .drop = "DROP",
        .@"continue" = "CONTINUE",
        .reject = "REJECT",
        .fms_ignore = "FMS_IGNORE",
    };
};
