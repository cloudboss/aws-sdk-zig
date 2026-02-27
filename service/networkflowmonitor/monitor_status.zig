pub const MonitorStatus = enum {
    pending,
    active,
    inactive,
    @"error",
    deleting,

    pub const json_field_names = .{
        .pending = "PENDING",
        .active = "ACTIVE",
        .inactive = "INACTIVE",
        .@"error" = "ERROR",
        .deleting = "DELETING",
    };
};
