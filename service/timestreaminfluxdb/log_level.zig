pub const LogLevel = enum {
    debug,
    info,
    @"error",

    pub const json_field_names = .{
        .debug = "DEBUG",
        .info = "INFO",
        .@"error" = "ERROR",
    };
};
