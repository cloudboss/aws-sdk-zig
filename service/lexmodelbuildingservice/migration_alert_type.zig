pub const MigrationAlertType = enum {
    @"error",
    warn,

    pub const json_field_names = .{
        .@"error" = "ERROR",
        .warn = "WARN",
    };
};
