pub const MarketType = enum {
    on_demand,
    spot,

    pub const json_field_names = .{
        .on_demand = "ON_DEMAND",
        .spot = "SPOT",
    };
};
