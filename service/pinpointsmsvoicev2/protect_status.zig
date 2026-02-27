pub const ProtectStatus = enum {
    allow,
    block,
    monitor,
    filter,

    pub const json_field_names = .{
        .allow = "ALLOW",
        .block = "BLOCK",
        .monitor = "MONITOR",
        .filter = "FILTER",
    };
};
