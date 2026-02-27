pub const RouteState = enum {
    active,
    blackhole,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .blackhole = "BLACKHOLE",
    };
};
