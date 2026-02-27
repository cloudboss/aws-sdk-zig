pub const LogLevel = enum {
    info,
    warn,
    @"error",
    debug,

    pub const json_field_names = .{
        .info = "INFO",
        .warn = "WARN",
        .@"error" = "ERROR",
        .debug = "DEBUG",
    };
};
