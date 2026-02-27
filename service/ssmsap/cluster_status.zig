pub const ClusterStatus = enum {
    online,
    standby,
    maintenance,
    offline,
    none,

    pub const json_field_names = .{
        .online = "ONLINE",
        .standby = "STANDBY",
        .maintenance = "MAINTENANCE",
        .offline = "OFFLINE",
        .none = "NONE",
    };
};
