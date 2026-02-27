/// The minimum level of log statements that should be logged by the OTA Agent
/// during an update.
pub const UpdateAgentLogLevel = enum {
    none,
    trace,
    debug,
    verbose,
    info,
    warn,
    @"error",
    fatal,

    pub const json_field_names = .{
        .none = "NONE",
        .trace = "TRACE",
        .debug = "DEBUG",
        .verbose = "VERBOSE",
        .info = "INFO",
        .warn = "WARN",
        .@"error" = "ERROR",
        .fatal = "FATAL",
    };
};
