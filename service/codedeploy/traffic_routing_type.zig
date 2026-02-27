pub const TrafficRoutingType = enum {
    time_based_canary,
    time_based_linear,
    all_at_once,

    pub const json_field_names = .{
        .time_based_canary = "TimeBasedCanary",
        .time_based_linear = "TimeBasedLinear",
        .all_at_once = "AllAtOnce",
    };
};
