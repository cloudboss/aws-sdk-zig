pub const LoggingLevel = enum {
    @"error",
    info,
    off,

    pub const json_field_names = .{
        .@"error" = "ERROR",
        .info = "INFO",
        .off = "OFF",
    };
};
