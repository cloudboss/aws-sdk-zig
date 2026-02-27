pub const FallbackAction = enum {
    @"continue",
    abort,

    pub const json_field_names = .{
        .@"continue" = "CONTINUE",
        .abort = "ABORT",
    };
};
