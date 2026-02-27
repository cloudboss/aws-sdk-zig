pub const DeviceStatus = enum {
    online,
    offline,
    retired,

    pub const json_field_names = .{
        .online = "ONLINE",
        .offline = "OFFLINE",
        .retired = "RETIRED",
    };
};
