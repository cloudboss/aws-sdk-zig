pub const LogLevel = enum {
    debug,
    @"error",
    info,
    warn,

    pub const json_field_names = .{
        .debug = "DEBUG",
        .@"error" = "ERROR",
        .info = "INFO",
        .warn = "WARN",
    };
};
