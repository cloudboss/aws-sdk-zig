pub const AgentStatusType = enum {
    routable,
    custom,
    offline,

    pub const json_field_names = .{
        .routable = "ROUTABLE",
        .custom = "CUSTOM",
        .offline = "OFFLINE",
    };
};
