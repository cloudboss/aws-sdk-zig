pub const LoggingLevel = enum {
    critical,
    @"error",
    warning,
    info,
    debug,

    pub const json_field_names = .{
        .critical = "CRITICAL",
        .@"error" = "ERROR",
        .warning = "WARNING",
        .info = "INFO",
        .debug = "DEBUG",
    };
};
