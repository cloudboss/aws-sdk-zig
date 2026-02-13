pub const PingStatus = enum {
    online,
    connection_lost,
    inactive,

    pub const json_field_names = .{
        .online = "ONLINE",
        .connection_lost = "CONNECTION_LOST",
        .inactive = "INACTIVE",
    };
};
