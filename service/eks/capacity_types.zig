pub const CapacityTypes = enum {
    on_demand,
    spot,
    capacity_block,

    pub const json_field_names = .{
        .on_demand = "ON_DEMAND",
        .spot = "SPOT",
        .capacity_block = "CAPACITY_BLOCK",
    };
};
