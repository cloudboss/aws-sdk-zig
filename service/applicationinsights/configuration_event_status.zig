pub const ConfigurationEventStatus = enum {
    info,
    warn,
    @"error",

    pub const json_field_names = .{
        .info = "INFO",
        .warn = "WARN",
        .@"error" = "ERROR",
    };
};
