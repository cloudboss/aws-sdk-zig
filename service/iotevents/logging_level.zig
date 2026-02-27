pub const LoggingLevel = enum {
    @"error",
    info,
    debug,

    pub const json_field_names = .{
        .@"error" = "ERROR",
        .info = "INFO",
        .debug = "DEBUG",
    };
};
