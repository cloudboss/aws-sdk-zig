pub const RoutingControlStateChange = enum {
    on,
    off,

    pub const json_field_names = .{
        .on = "ON",
        .off = "OFF",
    };
};
