pub const LogFilter = enum {
    @"error",
    warn,
    info,

    pub const json_field_names = .{
        .@"error" = "ERROR",
        .warn = "WARN",
        .info = "INFO",
    };
};
