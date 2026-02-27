pub const SpanStatus = enum {
    ok,
    @"error",
    timeout,

    pub const json_field_names = .{
        .ok = "OK",
        .@"error" = "ERROR",
        .timeout = "TIMEOUT",
    };
};
