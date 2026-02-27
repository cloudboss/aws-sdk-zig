pub const ClusterCapacityType = enum {
    spot,
    on_demand,

    pub const json_field_names = .{
        .spot = "SPOT",
        .on_demand = "ON_DEMAND",
    };
};
