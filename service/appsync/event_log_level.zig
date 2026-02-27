pub const EventLogLevel = enum {
    none,
    @"error",
    all,
    info,
    debug,

    pub const json_field_names = .{
        .none = "NONE",
        .@"error" = "ERROR",
        .all = "ALL",
        .info = "INFO",
        .debug = "DEBUG",
    };
};
