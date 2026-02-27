pub const LoggerLevel = enum {
    debug,
    info,
    warn,
    @"error",
    fatal,

    pub const json_field_names = .{
        .debug = "DEBUG",
        .info = "INFO",
        .warn = "WARN",
        .@"error" = "ERROR",
        .fatal = "FATAL",
    };
};
