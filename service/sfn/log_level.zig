pub const LogLevel = enum {
    all,
    @"error",
    fatal,
    off,

    pub const json_field_names = .{
        .all = "ALL",
        .@"error" = "ERROR",
        .fatal = "FATAL",
        .off = "OFF",
    };
};
