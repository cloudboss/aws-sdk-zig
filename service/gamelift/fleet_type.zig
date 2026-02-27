pub const FleetType = enum {
    on_demand,
    spot,

    pub const json_field_names = .{
        .on_demand = "OnDemand",
        .spot = "Spot",
    };
};
