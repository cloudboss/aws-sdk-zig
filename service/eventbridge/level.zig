pub const Level = enum {
    off,
    @"error",
    info,
    trace,

    pub const json_field_names = .{
        .off = "OFF",
        .@"error" = "ERROR",
        .info = "INFO",
        .trace = "TRACE",
    };
};
