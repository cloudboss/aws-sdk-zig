/// The log level for a log message. The log levels can be disabled, or set to
/// `ERROR` to display less verbose logs containing only error information,
/// or to `INFO` for more detailed logs.
pub const LogLevel = enum {
    info,
    @"error",
    disabled,

    pub const json_field_names = .{
        .info = "INFO",
        .@"error" = "ERROR",
        .disabled = "DISABLED",
    };
};
