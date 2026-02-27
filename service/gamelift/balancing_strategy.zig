pub const BalancingStrategy = enum {
    spot_only,
    spot_preferred,
    on_demand_only,

    pub const json_field_names = .{
        .spot_only = "SPOT_ONLY",
        .spot_preferred = "SPOT_PREFERRED",
        .on_demand_only = "ON_DEMAND_ONLY",
    };
};
