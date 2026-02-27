pub const LogLevel = enum {
    debug,
    info,
    @"error",
    warn,
    disabled,

    pub const json_field_names = .{
        .debug = "DEBUG",
        .info = "INFO",
        .@"error" = "ERROR",
        .warn = "WARN",
        .disabled = "DISABLED",
    };
};
