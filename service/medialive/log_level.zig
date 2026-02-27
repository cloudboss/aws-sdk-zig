/// The log level the user wants for their channel.
pub const LogLevel = enum {
    @"error",
    warning,
    info,
    debug,
    disabled,

    pub const json_field_names = .{
        .@"error" = "ERROR",
        .warning = "WARNING",
        .info = "INFO",
        .debug = "DEBUG",
        .disabled = "DISABLED",
    };
};
