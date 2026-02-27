pub const AgentStatus = enum {
    online,
    offline,

    pub const json_field_names = .{
        .online = "ONLINE",
        .offline = "OFFLINE",
    };
};
