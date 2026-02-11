pub const ApplicationLogLevel = enum {
    trace,
    debug,
    info,
    warn,
    @"error",
    fatal,

    pub const json_field_names = .{
        .trace = "Trace",
        .debug = "Debug",
        .info = "Info",
        .warn = "Warn",
        .@"error" = "Error",
        .fatal = "Fatal",
    };
};
