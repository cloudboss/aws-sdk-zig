pub const ContainerFleetBillingType = enum {
    on_demand,
    spot,

    pub const json_field_names = .{
        .on_demand = "ON_DEMAND",
        .spot = "SPOT",
    };
};
