pub const RoutingStrategyType = enum {
    simple,
    terminal,

    pub const json_field_names = .{
        .simple = "SIMPLE",
        .terminal = "TERMINAL",
    };
};
