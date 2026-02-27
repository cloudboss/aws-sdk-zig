pub const FleetOverflowBehavior = enum {
    queue,
    on_demand,

    pub const json_field_names = .{
        .queue = "QUEUE",
        .on_demand = "ON_DEMAND",
    };
};
