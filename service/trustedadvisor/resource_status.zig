pub const ResourceStatus = enum {
    ok,
    warning,
    @"error",

    pub const json_field_names = .{
        .ok = "OK",
        .warning = "WARNING",
        .@"error" = "ERROR",
    };
};
