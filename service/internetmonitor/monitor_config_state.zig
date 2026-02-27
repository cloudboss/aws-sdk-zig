pub const MonitorConfigState = enum {
    pending,
    active,
    inactive,
    @"error",

    pub const json_field_names = .{
        .pending = "PENDING",
        .active = "ACTIVE",
        .inactive = "INACTIVE",
        .@"error" = "ERROR",
    };
};
