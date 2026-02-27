pub const FlatInvocations = enum {
    @"continue",
    stop,

    pub const json_field_names = .{
        .@"continue" = "CONTINUE",
        .stop = "STOP",
    };
};
