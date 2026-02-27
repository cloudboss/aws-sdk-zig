pub const HypervisorState = enum {
    pending,
    online,
    offline,
    @"error",

    pub const json_field_names = .{
        .pending = "PENDING",
        .online = "ONLINE",
        .offline = "OFFLINE",
        .@"error" = "ERROR",
    };
};
