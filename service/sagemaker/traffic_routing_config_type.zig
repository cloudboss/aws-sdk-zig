pub const TrafficRoutingConfigType = enum {
    all_at_once,
    canary,
    linear,

    pub const json_field_names = .{
        .all_at_once = "ALL_AT_ONCE",
        .canary = "CANARY",
        .linear = "LINEAR",
    };
};
