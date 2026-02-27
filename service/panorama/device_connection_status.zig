pub const DeviceConnectionStatus = enum {
    online,
    offline,
    awaiting_credentials,
    not_available,
    @"error",

    pub const json_field_names = .{
        .online = "ONLINE",
        .offline = "OFFLINE",
        .awaiting_credentials = "AWAITING_CREDENTIALS",
        .not_available = "NOT_AVAILABLE",
        .@"error" = "ERROR",
    };
};
