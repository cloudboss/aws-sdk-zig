pub const RoutingScope = enum {
    regional,
    global,

    pub const json_field_names = .{
        .regional = "REGIONAL",
        .global = "GLOBAL",
    };
};
