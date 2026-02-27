pub const LogLevel = enum {
    @"error",
    info,

    pub const json_field_names = .{
        .@"error" = "ERROR",
        .info = "INFO",
    };
};
