pub const RouterOutputRoutedState = enum {
    routed,
    routing,
    unrouted,

    pub const json_field_names = .{
        .routed = "ROUTED",
        .routing = "ROUTING",
        .unrouted = "UNROUTED",
    };
};
