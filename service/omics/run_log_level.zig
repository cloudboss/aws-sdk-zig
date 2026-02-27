pub const RunLogLevel = enum {
    off,
    fatal,
    @"error",
    all,

    pub const json_field_names = .{
        .off = "OFF",
        .fatal = "FATAL",
        .@"error" = "ERROR",
        .all = "ALL",
    };
};
